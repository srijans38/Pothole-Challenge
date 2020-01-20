import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sih_test/services/firebase_storage_service.dart';
import 'package:sih_test/services/firestore_service.dart';

class ReportBox extends StatefulWidget {
  final Report report;
  ReportBox({this.report});

  @override
  _ReportBoxState createState() => _ReportBoxState();
}

class _ReportBoxState extends State<ReportBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(20.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              offset: Offset.fromDirection(20.0, 3.0),
              spreadRadius: 2.0,
              blurRadius: 5.0,
            ),
          ]),
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width - 40,
        minHeight: MediaQuery.of(context).size.height / 4,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FutureBuilder<String>(
              future: Provider.of<FirebaseStorageService>(context)
                  .getDownloadURL(widget.report.imageRef),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Image.network(
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
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes
                                : null,
                          ),
                        ),
                      );
                    },
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
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).size.height / 40,
              ),
              Text(
                widget.report.id,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                'Near ' + widget.report.landmark,
                style: TextStyle(
                  fontFamily: 'Montserrat',
                  fontSize: 15,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
