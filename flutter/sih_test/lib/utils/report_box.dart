import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sih_test/screens/report_screen.dart';
import 'package:sih_test/services/firebase_storage_service.dart';
import 'package:sih_test/services/firestore_service.dart';

class ReportBox extends StatefulWidget {
  final Report report;
  ReportBox({this.report});

  @override
  _ReportBoxState createState() => _ReportBoxState();
}

class _ReportBoxState extends State<ReportBox> {
  String imgUrl;

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 10.0,
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ReportScreen(
                      report: widget.report,
                      imgUrl: imgUrl,
                    )));
      },
      fillColor: Colors.blue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(20.0),
        ),
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width - 40,
          minHeight: MediaQuery.of(context).size.height / 4,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<String>(
              future: Provider.of<FirebaseStorageService>(context)
                  .getDownloadURL(widget.report.imageRef),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  imgUrl = snapshot.data;
                  return Hero(
                    tag: widget.report.id,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(
                        snapshot.data,
                        height: MediaQuery.of(context).size.height / 4,
                        width: MediaQuery.of(context).size.width / 3.5,
                        fit: BoxFit.cover,
                        loadingBuilder: (BuildContext context, Widget child,
                            ImageChunkEvent loadingProgress) {
                          if (loadingProgress == null) return child;
                          return SizedBox(
                            width: MediaQuery.of(context).size.width / 3.5,
                            height: MediaQuery.of(context).size.height / 4,
                            child: Center(
                              child: CircularProgressIndicator(
                                backgroundColor: Colors.grey,
                                valueColor:
                                    AlwaysStoppedAnimation<Color>(Colors.white),
                                value: loadingProgress.expectedTotalBytes !=
                                        null
                                    ? loadingProgress.cumulativeBytesLoaded /
                                        loadingProgress.expectedTotalBytes
                                    : null,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
                return SizedBox(
                  width: MediaQuery.of(context).size.width / 3.5,
                  height: MediaQuery.of(context).size.height / 4,
                  child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 20,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
//              SizedBox(
//                height: MediaQuery.of(context).size.height / 40,
//              ),
                Text(
                  widget.report.id,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  widget.report.landmark,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 40,
                ),
                Text(
                  widget.report.status,
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15,
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 40,
                ),
                Text(
                  'Created on',
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15,
                  ),
                ),
                Text(
                  DateFormat('d MMMM yy – hh:mm:a')
                      .format(widget.report.timestamp.toDate()),
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 15,
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
