import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_medial_app/auth/login_or_registerPage.dart';
import 'package:social_medial_app/pages/homepage.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //listen to the auth state changes to determine if the user is logged in or not
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //if the user is logged in, show the home page,
          if (snapshot.hasData) {
            return const Homepage();
          } else {
            //if the user is not logged in, show the login or register page
            return const LoginOrRegisterpage();
          }
        },
      ),
    );
  }
}
