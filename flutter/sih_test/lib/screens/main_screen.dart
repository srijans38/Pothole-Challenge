import 'package:camera/camera.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sih_test/screens/profile_screen.dart';

FirebaseAuth _auth = FirebaseAuth.instance;
GoogleSignIn _googleSignIn = GoogleSignIn();

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  CameraDescription camera;

  int _currentIndex = 0;
  final List<Widget> _children = [
    Center(child: Text('Home')),
    ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();

    getCameras().then((cameras) {
      camera = cameras.first;
    });
  }

  Future<List<CameraDescription>> getCameras() async {
    return await availableCameras();
  }

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
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('Profile'),
          )
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
