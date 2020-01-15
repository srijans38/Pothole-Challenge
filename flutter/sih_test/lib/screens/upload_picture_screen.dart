import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';
import 'package:sih_test/screens/upload_report_screen.dart';
import 'package:sih_test/services/firebase_auth_service.dart';

class DisplayPictureScreen extends StatefulWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
}

class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  String uploadedImageRef;

  Future uploadFile(String uid) async {
    StorageReference storageReference = FirebaseStorage.instance
        .ref()
        .child('reports/$uid/${basename(widget.imagePath)}');
    StorageUploadTask uploadTask =
        storageReference.putFile(File(widget.imagePath));
    uploadTask.events.listen((data) {
      print(data.snapshot.totalByteCount);
    });
    storageReference.getPath().then((value) {
      uploadedImageRef = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: 200,
              child: Image.file(File(widget.imagePath)),
            ),
            RaisedButton(
              onPressed: () async {
                print(basename(widget.imagePath));
                final user = await Provider.of<FirebaseAuthService>(context,
                        listen: false)
                    .getCurrentUser();
                uploadFile(user.uid).then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UploadReportScreen(
                                imageRef: uploadedImageRef,
                              )));
                });
              },
              child: Text('Upload'),
            ),
          ],
        ),
      ),
    );
  }
}
