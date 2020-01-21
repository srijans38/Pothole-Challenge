import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sih_test/services/auth_widget.dart';
import 'package:sih_test/services/firebase_storage_service.dart';
import 'package:sih_test/services/firestore_service.dart';

class ReportScreen extends StatelessWidget {
  final Report report;
  final String imgUrl;

  ReportScreen({this.report, this.imgUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.width / 4.5,
            decoration: BoxDecoration(
//            boxShadow: [
//              BoxShadow(
//                color: Colors.grey.withOpacity(0.5),
//                offset: Offset.fromDirection(45.0),
//                blurRadius: 20.0,
//                spreadRadius: 0.0,
//              ),
//            ],
//            color: Colors.white,
                ),
            padding: EdgeInsets.only(top: 30.0, right: 30.0, left: 30.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    size: 25.0,
                  ),
                ),
                Text(
                  report.id,
                  style: TextStyle(
                    fontSize: 15.0,
                    fontFamily: 'Montserrat',
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                IconButton(
                  onPressed: () async {},
                  icon: Icon(
                    Icons.exit_to_app,
                    size: 25.0,
                  ),
                ),
              ],
            ),
          ),
          Hero(
            tag: report.id,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(0),
              child: Image.network(
                imgUrl,
                height: 500.0,
              ),
            ),
          ),
          RaisedButton(
            child: Text('Delete'),
            onPressed: () async {
              await Provider.of<FirestoreService>(context)
                  .deleteReport(report.id);
              await Provider.of<FirebaseStorageService>(context)
                  .deleteImage(report.imageRef);
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => AuthWidget()),
                  (Route route) => false);
            },
          )
        ],
      ),
    );
  }
}
