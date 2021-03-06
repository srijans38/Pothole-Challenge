import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:sih_test/services/firestore_service.dart';
import 'package:sih_test/utils/text_field.dart';

class UploadBottomModal extends StatefulWidget {
  final String imageRef;
  final String uid;
  final BuildContext progressContext;
  final String imagePath;

  UploadBottomModal(
      {this.imageRef, this.uid, this.progressContext, this.imagePath});

  @override
  _UploadBottomModalState createState() => _UploadBottomModalState();
}

class _UploadBottomModalState extends State<UploadBottomModal> {
  String landmark;
  FirebaseVisionImage visionImage;
  final ImageLabeler labeler = FirebaseVision.instance
      .imageLabeler(ImageLabelerOptions(confidenceThreshold: 0.7));
  List<Map<String, dynamic>> _labels = [];

  List<Map> labelsToMap(List<ImageLabel> labels) {
    List<Map<String, dynamic>> mapLabels = [];
    labels.forEach((e) {
      mapLabels.add({
        'label': '${e.text}',
        'confidence': '${e.confidence}',
      });
    });
    return mapLabels;
  }

  @override
  void initState() {
    super.initState();
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
                visionImage =
                    FirebaseVisionImage.fromFilePath(widget.imagePath);
                final labels = await labeler.processImage(visionImage);
                _labels = labelsToMap(labels);
                print(_labels);
                Position position = await Geolocator().getCurrentPosition();
                Map geocode;
                String region;
                try {
                  var regionJson = await http.get(
                      'https://www.geocode.xyz/${position.latitude},${position.longitude}?json=1');
                  geocode = json.decode(regionJson.body);
                  region = geocode['staddress'].toString() +
                      ',' +
                      geocode['city'].toString() +
                      ',' +
                      geocode['poi']['name'].toString() +
                      ',' +
                      geocode['poi']['addr-street'].toString();
                  print(region);
                } catch (e) {
                  print(e);
                  region = geocode['city'].toString() +
                      ',' +
                      geocode['region'].toString();
                  print(region);
                }
                final report = Report(
                  uid: [widget.uid],
                  imageRef: widget.imageRef,
                  landmark: landmark,
                  region: region,
                  location: GeoPoint(position.latitude, position.longitude),
                  timestamp: Timestamp.now(),
                  status: 'Reported',
                  occurrence: 1,
                  labels: _labels,
                );
                Provider.of<FirestoreService>(widget.progressContext,
                        listen: false)
                    .uploadReport(report)
                    .then((value) {
                  print(value.path);
                  progress.dismiss();
                  Navigator.pop(widget.progressContext);
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
