import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

Firestore _firestore = Firestore.instance;

class UploadReportScreen extends StatefulWidget {
  final String imageRef;

  UploadReportScreen({this.imageRef});

  @override
  _UploadReportScreenState createState() => _UploadReportScreenState();
}

class _UploadReportScreenState extends State<UploadReportScreen> {
  var filepath;

  Future<File> downloadImage() async {
    filepath =
        join((await getTemporaryDirectory()).path, '${DateTime.now()}.png');
    final StorageReference storageReference =
        FirebaseStorage.instance.ref().child(widget.imageRef);
    StorageFileDownloadTask fileDownloadTask =
        storageReference.writeToFile(File(filepath));
    await fileDownloadTask.future;
    return File(filepath);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<File>(
          future: downloadImage(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                width: 200,
                child: Image.file(snapshot.data),
              );
            }
            return Center(
              child: Container(
                width: 200,
                height: 200,
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ),
    );
  }
}
