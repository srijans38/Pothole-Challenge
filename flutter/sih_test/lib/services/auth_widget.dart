import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sih_test/main_screen.dart';
import 'package:sih_test/screens/login_screen.dart';
import 'package:sih_test/services/firebase_auth_service.dart';

class AuthWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authService =
        Provider.of<FirebaseAuthService>(context, listen: false);

    return StreamBuilder<User>(
      stream: authService.onAuthStateChanged,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final user = snapshot.data;
          return user != null ? MainScreen() : LoginScreen();
        }
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
