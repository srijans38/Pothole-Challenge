import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:sih_test/services/firestore_service.dart';
import 'package:sih_test/utils/text_field.dart';

class FeedbackBottomModal extends StatefulWidget {
  final progressContext;
  final reportId;

  FeedbackBottomModal({this.progressContext, this.reportId});

  @override
  _FeedbackBottomModalState createState() => _FeedbackBottomModalState();
}

class _FeedbackBottomModalState extends State<FeedbackBottomModal> {
  String feedback;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'ENTER YOUR FEEDBACK',
            style: TextStyle(
              fontFamily: 'Montserrat',
              fontSize: 20.0,
              fontWeight: FontWeight.w700,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: CustomTextField(
              onChanged: (value) {
                feedback = value;
              },
              obscureText: false,
              hintText: 'Feedback',
            ),
          ),
          ButtonTheme(
            minWidth: MediaQuery.of(context).size.width - 40,
            height: 60.0,
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.blueAccent,
              onPressed: () async {
                Navigator.pop(context);
                final progress = ProgressHUD.of(widget.progressContext);
                progress.showWithText('Uploading...');
                Provider.of<FirestoreService>(context).uploadFeedback(feedback, widget.reportId).then((value) {
                  progress.dismiss();
                });
              },
              child: Text(
                'Submit Feedback',
                style: TextStyle(
                  fontSize: 15.0,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}