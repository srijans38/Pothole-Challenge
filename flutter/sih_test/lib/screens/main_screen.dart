import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sih_test/screens/home_screen.dart';
import 'package:sih_test/screens/profile_screen.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
GoogleSignIn _googleSignIn = GoogleSignIn();

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    HomeScreen(),
    Center(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RawMaterialButton(
              constraints: BoxConstraints(minHeight: 200.0),
              onPressed: () {},
              child: Text('Report a new pothole'),
            )
          ],
        ),
      ),
    ),
    ProfileScreen(),
  ];

  void onBottomTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onBottomTapped,
        currentIndex: _currentIndex,
        backgroundColor: ThemeData.light().canvasColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.camera_alt),
            title: Text('Report'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          ),
        ],
      ),
    );
  }
}

//Column(
//mainAxisAlignment: MainAxisAlignment.center,
//crossAxisAlignment: CrossAxisAlignment.center,
//children: <Widget>[
//Center(child: Text(Provider.of<User>(context).email)),
//RaisedButton(
//onPressed: () async {
//await Provider.of<FirebaseAuthService>(context, listen: false)
//.signOut();
//},
//child: Text('Sign out'),
//),
//RaisedButton(
//onPressed: (camera != null)
//? () {
//Navigator.push(
//context,
//MaterialPageRoute(
//builder: (context) => TakePictureScreen(
//camera: camera,
//)));
//}
//    : () {},
//child: Text('Sign out'),
//),
//],
//),
