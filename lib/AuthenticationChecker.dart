import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:towedd/LoginPageUser.dart';
import 'package:towedd/UserHome.dart';

class AuthenticationChecker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData) {
          return UserHome();
        } else {
          return LoginPageUser();
        }
      },
    );
  }
}
