import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  final String imageRef;
  final String landmark;
  final GeoPoint location;
  final Timestamp timestamp;
  final List uid;
  Report(
      {this.imageRef, this.landmark, this.location, this.timestamp, this.uid});

  factory Report.fromMap(Map data) {
    return (Report(
      imageRef: data['image'],
      landmark: data['landmark'],
      location: data['location'],
      timestamp: data['timestamp'],
      uid: data['uid'],
    ));
  }

  Map<String, dynamic> toMap() {
    return {
      'image': this.imageRef,
      'landmark': this.landmark,
      'location': [this.location.latitude, this.location.longitude],
      'timestamp': this.timestamp,
      'uid': this.uid,
    };
  }
}

class FirestoreService {
  final _firestore = Firestore.instance;

  Future<List<Report>> getReports() async {
    final reportDocs = await _firestore.collection('reports').getDocuments();
    List<Report> reports = [];
    for (var report in reportDocs.documents) {
      print(report.data);
      reports.add(Report.fromMap(report.data));
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

  Future<DocumentReference> uploadReport(Report report) async {
    return await _firestore.collection('reports').add(report.toMap());
  }
}
