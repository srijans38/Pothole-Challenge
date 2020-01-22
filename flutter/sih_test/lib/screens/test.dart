import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Firestore _firestore = Firestore.instance;

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  File imageFile;
  FirebaseVisionImage visionImage;
  final ImageLabeler labeler = FirebaseVision.instance.imageLabeler();
  List<ImageLabel> _labels = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getImageFile().then((value) async {
      imageFile = value;
      visionImage = FirebaseVisionImage.fromFile(imageFile);
      final List<ImageLabel> labels = await labeler.processImage(visionImage);
      setState(() {
        _labels = labels;
      });
      labels.forEach((e) {
        print(e.text);
        print(e.confidence);
      });
    });
  }

  Future<File> getImageFile() async {
    return await ImagePicker.pickImage(source: ImageSource.gallery);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    labeler.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
            itemCount: _labels.length,
            itemBuilder: (context, index) {
              if (_labels.isNotEmpty) {
                return Column(
                  children: <Widget>[
                    Text(_labels[index].text),
                    Text(_labels[index].confidence.toString()),
                    SizedBox(
                      height: 30.0,
                    ),
                  ],
                );
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }
}
