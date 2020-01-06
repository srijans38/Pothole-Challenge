import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sih_test/anim.dart';
import 'package:sih_test/auth.dart';
import 'package:sih_test/main_screen.dart';
import 'package:sih_test/screens/login_email.dart';

import '../icon_button.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseUser loggedinUser;

  @override
  void initState() {
    super.initState();
    getCurrentUser().then((FirebaseUser u) {
      loggedinUser = u;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 0),
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    constraints: BoxConstraints(
                      minHeight: 180,
                    ),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0, 0.2, 0.8],
                        colors: [
                          Color(0xff4285f4),
                          Color(0xff75bdff),
                          Colors.white
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Hero(
                          tag: 'head',
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              'Welcome',
                              style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'Montserrat',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Hero(
                          tag: 'subtext',
                          child: Material(
                            color: Colors.transparent,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 50.0),
                              child: Text(
                                'Use your email address or phone number to sign up.',
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 80.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: CustomIconButton(
                            onPressed: () {
                              signInWithGoogle().then((FirebaseUser user) {
                                loggedinUser = user;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MainScreen()));
                              });
                            },
                            color: Color(0xff4285f4),
                            image: 'assets/google-logo.png',
                            text: 'Continue with Google',
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: CustomIconButton(
                            icon: Icons.phone,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PhoneSignInSection()));
                            },
                            color: Color(0xff75bdff),
                            text: 'Continue with Phone',
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        Center(
                          child: Text(
                            'OR',
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 25.0,
                        ),
                        Hero(
                          tag: 'email',
                          child: SizedBox(
                            width: double.infinity,
                            child: CustomIconButton(
                              icon: Icons.alternate_email,
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => LoginEmail()));
                              },
                              color: Color(0xff75bdff),
                              text: 'Continue with Email',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned.fill(
            top: -80,
            child: Align(
              alignment: Alignment.topCenter,
              child: AnimCar(),
            ),
          ),
        ],
      ),
    );
  }
}
