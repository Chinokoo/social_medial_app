import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_medial_app/components/wall_button.dart';
import 'package:social_medial_app/components/wall_textField.dart';

class RegisterPage extends StatelessWidget {
  final void Function() onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    //controllers
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmPasswordController = TextEditingController();

    //login function
    void signUp() {
      //TODO: implement signup functionality.
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
