import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sih_test/auth.dart';

class Test extends StatefulWidget {
  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  String email = "";

  @override
  void initState() {
    super.initState();
    getCurrentUser().then((FirebaseUser user) {
      setState(() {
        email = user.email;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(child: Text(email)),
      ),
    );
  }
}
