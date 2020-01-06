import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sih_test/auth.dart';
import 'package:sih_test/screens/login_screen.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
GoogleSignIn _googleSignIn = GoogleSignIn();

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(child: Text(email)),
            RaisedButton(
              onPressed: () async {
                signOutWithGoogle();
                _auth.signOut().then((value) {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                      (Route route) => false);
                });
              },
              child: Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
