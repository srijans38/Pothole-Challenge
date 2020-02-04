import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  final String id;
  final String imageRef;
  final String landmark;
  final GeoPoint location;
  final Timestamp timestamp;
  final List uid;
  final String region;
  final String status;
  final String feedback;
  final int occurrence;
  final List labels;

  Report({
    this.imageRef,
    this.landmark,
    this.location,
    this.timestamp,
    this.uid,
    this.id,
    this.region,
    this.status,
    this.feedback,
    this.occurrence,
    this.labels,
  });

  factory Report.fromMap(Map data, String id) {
    return (Report(
      id: id,
      imageRef: data['image'],
      landmark: data['landmark'],
      location: data['location'],
      timestamp: data['timestamp'],
      uid: data['uid'],
      region: data['region'],
      status: data['status'],
      feedback: data['feedback'],
      occurrence: data['occurrence'],
      labels: data['labels'],
    ));
  }

  Map<String, dynamic> toMap() {
    return {
      'image': this.imageRef,
      'landmark': this.landmark,
      'location': this.location,
      'timestamp': this.timestamp,
      'uid': this.uid,
      'region': this.region,
      'status': this.status,
      'feedback': this.feedback,
      'occurrence': this.occurrence,
      'labels': this.labels,
    };
  }
}

class FirestoreService {
  final _firestore = Firestore.instance;

  Future<List<Report>> getReports() async {
    final reportDocs = await _firestore.collection('reports').getDocuments();
    List<Report> reports = [];
    for (var report in reportDocs.documents) {
      reports.add(Report.fromMap(report.data, report.documentID));
    }
    return reports;
  }

  Stream<QuerySnapshot> getReportsStream() {
    return _firestore.collection('reports').snapshots();
  }

  Stream<QuerySnapshot> getReportsByUser(String uid) {
    return _firestore
        .collection('reports')
        .where('uid', arrayContains: uid)
        .orderBy('timestamp', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getLeaderboard() {
    return _firestore
        .collection('leaderboard')
        .orderBy('points', descending: true)
        .snapshots();
  }

  Future<void> uploadFeedback(String feedback, String reportId) async {
    final data = {'feedback' : feedback};
    return await _firestore.collection('reports').document(reportId).updateData(data);
  }

  Future<DocumentReference> uploadReport(Report report) async {
    return await _firestore.collection('reports').add(report.toMap());
  }

  Stream<DocumentSnapshot> getPointsByUser(String uid) {
    return _firestore.collection('leaderboard').document(uid).snapshots();
  }

  Future<void> deleteReport(String id, String uid) async {
    return await _firestore.collection('reports').document(id).delete();
  }
}
