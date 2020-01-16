import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sih_test/services/auth_widget.dart';
import 'package:sih_test/services/firebase_auth_service.dart';
import 'package:sih_test/utils/text_field.dart';

import '../utils/icon_button.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class SignupEmail extends StatefulWidget {
  @override
  _SignupEmailState createState() => _SignupEmailState();
}

class _SignupEmailState extends State<SignupEmail> {
  String email;
  String password;
  final globalKey = GlobalKey<ScaffoldState>();

  void showSnackbar(BuildContext context, String text) {
    final snackBar = SnackBar(content: Text(text));
    globalKey.currentState.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                minHeight: 180,
                maxHeight: 180,
              ),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0, 0.2, 0.8],
                  colors: [Color(0xff4285f4), Color(0xff75bdff), Colors.white],
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Material(
                  color: Colors.transparent,
                  child: Text(
                    'Signup',
                    style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'Montserrat',
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                Material(
                  color: Colors.transparent,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 50.0),
                    child: Text(
                      'Use your email address and password to signup.',
                      style: TextStyle(
                        fontSize: 15.0,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.0,
                ),
                CustomTextField(
                  obscureText: false,
                  hintText: 'Email Address',
                  onChanged: (String value) {
                    email = value;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                CustomTextField(
                  obscureText: true,
                  hintText: 'Password',
                  onChanged: (String value) {
                    password = value;
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Hero(
                  tag: 'email',
                  child: SizedBox(
                    width: double.infinity,
                    child: CustomIconButton(
                      icon: Icons.alternate_email,
                      onPressed: () {
                        Provider.of<FirebaseAuthService>(context, listen: false)
                            .createUserWithEmailAndPassword(
                                email: email, password: password)
                            .then((result) {
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AuthWidget()),
                              (Route route) => false);
                        }).catchError((error, stackTrace) {
                          print(error);
                          if (error.code == 'ERROR_EMAIL_ALREADY_IN_USE') {
                            showSnackbar(context,
                                'The email address is already in use by another account. Please try again or sign in.');
                          } else if (error.code == 'ERROR_WEAK_PASSWORD') {
                            showSnackbar(context,
                                'Password should be at least 6 characters. Please try again.');
                          } else {
                            showSnackbar(context, error.code.toString());
                          }
                        });
                      },
                      color: Color(0xff75bdff),
                      text: 'Sign up with Email',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
