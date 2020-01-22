import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sih_test/services/auth_widget.dart';
import 'package:sih_test/services/firestore_service.dart';
import 'package:sih_test/utils/text_field.dart';

class UploadBottomModal extends StatefulWidget {
  final String imageRef;
  final String uid;
  final BuildContext progressContext;

  UploadBottomModal({this.imageRef, this.uid, this.progressContext});

  @override
  _UploadBottomModalState createState() => _UploadBottomModalState();
}

class _UploadBottomModalState extends State<UploadBottomModal> {
  String landmark;

  @override
  void initState() {
    super.initState();
    print(widget.imageRef);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.5,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Text(
            'ENTER A LANDMARK',
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
                landmark = value;
              },
              obscureText: false,
              hintText: 'Landmark',
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
                Navigator.pop(context);
                final progress = ProgressHUD.of(widget.progressContext);
                progress.showWithText('Uploading...');
                Position position = await Geolocator().getCurrentPosition();
                var regionJson = await http.get(
                    'https://www.geonames.org/findNearbyPlaceName?lat=${position.latitude}&lng=${position.longitude}&type=json');
                String region =
                    json.decode(regionJson.body)['geonames'][0]['toponymName'];
                final report = Report(
                  uid: [widget.uid],
                  imageRef: widget.imageRef,
                  landmark: landmark,
                  region: region,
                  location: GeoPoint(position.latitude, position.longitude),
                  timestamp: Timestamp.now(),
                  status: 'Reported',
                  occurrence: 1,
                );
                Provider.of<FirestoreService>(widget.progressContext,
                        listen: false)
                    .uploadReport(report)
                    .then((value) {
                  print(value.path);
                  progress.dismiss();
                  Navigator.pushAndRemoveUntil(
                      widget.progressContext,
                      MaterialPageRoute(builder: (context) => AuthWidget()),
                      (Route route) => false);
                });
              },
              child: Text(
                'Submit Report',
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
