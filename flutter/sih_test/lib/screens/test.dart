import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Firestore _firestore = Firestore.instance;

class TestScreen extends StatefulWidget {
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _firestore.collection('reports').getDocuments().then((value) {
      value.documents.forEach((doc) {
        print(doc.data['landmark']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
