import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sih_test/services/auth_widget.dart';
import 'package:sih_test/services/firebase_auth_service.dart';
import 'package:sih_test/services/firebase_storage_service.dart';
import 'package:sih_test/services/firestore_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<FirebaseAuthService>(
          create: (_) => FirebaseAuthService(),
        ),
        Provider<FirestoreService>(
          create: (_) => FirestoreService(),
        ),
        Provider<FirebaseStorageService>(
          create: (_) => FirebaseStorageService(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: AuthWidget(),
        theme: ThemeData.light().copyWith(
          canvasColor: Colors.transparent,
        ),
      ),
    );
  }
}
