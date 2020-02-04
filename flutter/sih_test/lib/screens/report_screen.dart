import 'package:esys_flutter_share/esys_flutter_share.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:sih_test/services/firestore_service.dart';
import 'package:sih_test/utils/feedback_bottom_modal.dart';

class ReportScreen extends StatefulWidget {
  final Report report;
  final String imgUrl;

  ReportScreen({this.report, this.imgUrl});

  @override
  _ReportScreenState createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  BuildContext _buildContext;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ProgressHUD(
          barrierEnabled: true,
          backgroundColor: Colors.blue.withOpacity(0.8),
          child: Builder(
            builder: (context) {
              _buildContext = context; 
              return Column(
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
                        widget.report.id,
                        style: TextStyle(
                          fontSize: 15.0,
                          fontFamily: 'Montserrat',
                          letterSpacing: 2.0,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          Share.text('Pothole Report', 'Hey! I reported a new pothole at ${widget.report.location.latitude}, ${widget.report.location.longitude}', 'text/plain');
                        },
                        icon: Icon(
                          Icons.share,
                          size: 25.0,
                        ),
                      ),
                    ],
                  ),
                ),
                Hero(
                  tag: widget.report.id,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(0),
                    child: Image.network(
                      widget.imgUrl,
                      height: 500.0,
                    ),
                  ),
                ),
                RaisedButton(
                  child: Text('Add Feedback'),
                  onPressed: () async {
                    showBottomSheet(context: context, builder: (context) {
                      return FeedbackBottomModal(
                        progressContext: context,
                        reportId: widget.report.id,
                      );
                    });
                  },
                ),
                RaisedButton(
                  child: Text('Delete'),
                  onPressed: () async {
                    final progress = ProgressHUD.of(context);
                    progress.showWithText('Deleting...');
                    await Provider.of<FirestoreService>(context)
                        .deleteReport(widget.report.id, widget.report.uid[0]);
                    progress.dismiss();
                    Navigator.pop(context);
                  },
                )
              ],
            );
            }
          )),
    );
  }
}
