import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_medial_app/auth/auth_service.dart';
import 'package:social_medial_app/components/wall_button.dart';
import 'package:social_medial_app/components/wall_textField.dart';
import 'package:social_medial_app/errors/error_handler.dart';

class LoginPage extends StatelessWidget {
  final void Function() onTap;
  const LoginPage({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    //controllers
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    //login function
    void login() async {
      //TODO: implement login functionality.
      //auth service.
      final authService = AuthService();
      //logging in.
      try {
        await authService.signInWithEmailAndPassword(
            context, emailController.text, passwordController.text);
      } catch (e) {
        ErrorHandler.showError(context, "Error :${e.toString()}");
      }
    }

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //spacing
              const SizedBox(
                height: 100,
              ),
              //icon.
              Center(
                child: Icon(Icons.person,
                    size: 200,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
              //spacing
              const SizedBox(
                height: 5,
              ),

              //text.
              Text(
                "T H E   W A L L",
                style: GoogleFonts.robotoCondensed(
                    fontWeight: FontWeight.bold,
                    fontSize: 80,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),

              //email input.
              WallTextfield(
                controller: emailController,
                hintText: "Email",
                obscureText: false,
              ),
              //password input.
              WallTextfield(
                controller: passwordController,
                hintText: "Password",
                obscureText: true,
              ),
              //log in button.
              WallButton(
                buttonText: "login",
                onTap: login,
              ),
              //go to register page.
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 26),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(width: 5),
                    GestureDetector(
                        onTap: onTap,
                        child: Text("Sign Up here",
                            style: GoogleFonts.roboto(
                                fontSize: 20, fontWeight: FontWeight.bold))),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
