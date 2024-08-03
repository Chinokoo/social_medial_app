import 'package:flutter/material.dart';
import 'package:social_medial_app/pages/login_page.dart';
import 'package:social_medial_app/pages/register_page.dart';

class LoginOrRegisterpage extends StatefulWidget {
  const LoginOrRegisterpage({super.key});

  @override
  State<LoginOrRegisterpage> createState() => _LoginOrRegisterpageState();
}

class _LoginOrRegisterpageState extends State<LoginOrRegisterpage> {
  //boolean variable log in page is true by default
  bool showLoginPage = true;
  //method to toggle between login and register pages
  void togglePages() {
    setState(() {
      //TODO: implement togglePages method
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTap: togglePages,
      );
    } else {
      return RegisterPage(
        onTap: togglePages,
      );
    }
  }
}
