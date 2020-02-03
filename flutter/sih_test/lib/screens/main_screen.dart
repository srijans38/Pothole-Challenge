import 'package:bubble_bottom_bar/bubble_bottom_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sih_test/screens/home_screen.dart';
import 'package:sih_test/screens/leaderboard.dart';
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
    LeaderboardScreen(),
    ProfileScreen(),
  ];

  void onBottomTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _children,
        ),
        bottomNavigationBar: BubbleBottomBar(
          hasInk: true,
          iconSize: 24.0,
          currentIndex: _currentIndex,
          onTap: onBottomTapped,
          opacity: 0.2,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          elevation: 50,
          hasNotch: true,
          items: <BubbleBottomBarItem>[
            BubbleBottomBarItem(
                backgroundColor: Colors.blue,
                icon: Icon(
                  Icons.dashboard,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.dashboard,
                  color: Colors.blue,
                ),
                title: Text(
                  "Home",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                  ),
                )),
            BubbleBottomBarItem(
                backgroundColor: Colors.blue,
                icon: Icon(
                  Icons.format_list_numbered,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.format_list_numbered,
                  color: Colors.blue,
                ),
                title: Text(
                  "Leaderboard",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                  ),
                )),
            BubbleBottomBarItem(
                backgroundColor: Colors.blue,
                icon: Icon(
                  Icons.person,
                  color: Colors.black,
                ),
                activeIcon: Icon(
                  Icons.person,
                  color: Colors.blue,
                ),
                title: Text(
                  "Profile",
                  style: TextStyle(
                    fontFamily: 'Montserrat',
                  ),
                )),
          ],
        ));
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
