import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sih_test/anim.dart';
import 'package:sih_test/auth.dart';
import 'package:sih_test/test.dart';

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
                        Text(
                          'Welcome',
                          style: TextStyle(
                            fontSize: 40.0,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Montserrat',
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        Padding(
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
                        SizedBox(
                          height: 80.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: IconButton(
                            onPressed: () {
                              signInWithGoogle().then((FirebaseUser user) {
                                loggedinUser = user;
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Test()));
                              });
                            },
                            color: Color(0xff4285f4),
                            image: 'assets/google-logo.png',
                            text: 'Sign up with Google',
                          ),
                        ),
                        SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: IconButton(
                            icon: Icons.phone,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PhoneSignInSection()));
                            },
                            color: Color(0xff75bdff),
                            text: 'Sign up with Phone',
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
                        SizedBox(
                          width: double.infinity,
                          child: IconButton(
                            icon: Icons.alternate_email,
                            onPressed: () {},
                            color: Color(0xff75bdff),
                            text: 'Sign up with Email',
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

class IconButton extends StatelessWidget {
  final IconData icon;
  final Function onPressed;
  final Color color;
  final String image;
  final String text;

  IconButton({
    @required this.onPressed,
    this.icon,
    this.image,
    @required this.text,
    @required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      elevation: 20.0,
      onPressed: onPressed,
      fillColor: color,
      constraints: BoxConstraints(
        minHeight: 70.0,
        minWidth: 200.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            width: 30.0,
          ),
          Material(
            borderRadius: BorderRadius.circular(50.0),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: (image == null)
                  ? Icon(
                      icon,
                      size: 30.0,
                    )
                  : Image.asset(
                      image,
                      height: 30,
                      width: 30,
                    ),
            ),
          ),
          SizedBox(
            width: 30.0,
          ),
          Text(
            text,
            style: TextStyle(
                fontSize: 20.0,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    );
  }
}
