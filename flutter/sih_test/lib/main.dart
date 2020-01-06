import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sih_test/main_screen.dart';
import 'package:sih_test/screens/login_screen.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget home = Scaffold(
    body: Center(
      child: Container(
        constraints: BoxConstraints(
          maxHeight: 100,
        ),
        child: CircularProgressIndicator(),
      ),
    ),
  );

  @override
  void initState() {
    super.initState();
    //home = LoginScreen();
    _auth.currentUser().then((FirebaseUser user) {
      if (user != null) {
        setState(() {
          home = MainScreen();
        });
      } else {
        setState(() {
          home = LoginScreen();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: home,
    );
  }
}
