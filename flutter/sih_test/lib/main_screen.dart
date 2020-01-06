import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sih_test/auth.dart';
import 'package:sih_test/screens/login_screen.dart';
import 'package:sih_test/screens/take_picture_screen.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
GoogleSignIn _googleSignIn = GoogleSignIn();

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String email = "";
  CameraDescription camera;

  @override
  void initState() {
    super.initState();
    getCurrentUser().then((FirebaseUser user) {
      setState(() {
        email = user.email;
      });
      getCameras().then((cameras) {
        camera = cameras.first;
      });
    });
  }

  Future<List<CameraDescription>> getCameras() async {
    return await availableCameras();
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
            RaisedButton(
              onPressed: (camera != null)
                  ? () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => TakePictureScreen(
                                    camera: camera,
                                  )));
                    }
                  : () {},
              child: Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
