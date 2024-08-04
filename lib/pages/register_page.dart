import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_medial_app/auth/auth_service.dart';
import 'package:social_medial_app/components/wall_button.dart';
import 'package:social_medial_app/components/wall_textField.dart';
import 'package:social_medial_app/errors/error_handler.dart';

class RegisterPage extends StatelessWidget {
  final void Function() onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    //controllers
    TextEditingController usernameController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    //login function
    void signUp() async {
      // Check for empty fields
      if (usernameController.text.isEmpty ||
          emailController.text.isEmpty ||
          passwordController.text.isEmpty ||
          confirmPasswordController.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Please fill in all fields",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ));
        return;
      }
      try {
        if (passwordController.text == confirmPasswordController.text) {
          final authService = AuthService();

          await authService.signUpWithEmailAndPassword(
              context, emailController.text, passwordController.text);
        } else {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
              "passwords do not match",
              style: TextStyle(fontSize: 25, color: Colors.white),
            ),
            backgroundColor: Colors.red,
          ));
        }
      } on FirebaseAuthException catch (e) {
        if (context.mounted) {
          ErrorHandler.showError(context, "Error :${e.toString()}");
        }
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
                height: 80,
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
                "Register With ",
                style: GoogleFonts.robotoCondensed(
                    fontWeight: FontWeight.bold,
                    fontSize: 80,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
              Text(
                "                         T H E     W A L L !",
                style: GoogleFonts.robotoCondensed(
                    fontSize: 40, fontWeight: FontWeight.bold),
                textAlign: TextAlign.right,
              ),
              WallTextfield(
                  hintText: "Name",
                  obscureText: false,
                  controller: usernameController),
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
              WallTextfield(
                controller: confirmPasswordController,
                hintText: "Confirm Password",
                obscureText: true,
              ),
              //log in button.
              WallButton(
                buttonText: "register",
                onTap: signUp,
              ),
              //go to register page.
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 26),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
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
                        child: Text("Login here",
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
