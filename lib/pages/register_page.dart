import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:social_medial_app/auth/auth_service.dart';
import 'package:social_medial_app/components/wall_button.dart';
import 'package:social_medial_app/components/wall_textField.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

    // create a user document and collect them in firestore.
    Future<void> createUserDocument(UserCredential? userCredential) async {
      if (userCredential != null && userCredential.user != null) {
        await FirebaseFirestore.instance
            .collection('Users')
            .doc(userCredential.user!.email)
            .set({
          'email': userCredential.user!.email,
          'username': usernameController.text,
        });
      }
    }

    //login function
    void signUp() async {
      //showing a loading indicator
      showDialog(
          context: context,
          builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ));
      // Check for empty fields
      if (usernameController.text.isEmpty ||
          emailController.text.isEmpty ||
          passwordController.text.isEmpty ||
          confirmPasswordController.text.isEmpty) {
        //popping the loading indicator.
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
            "Please fill in all fields",
            style: TextStyle(fontSize: 25, color: Colors.white),
          ),
          backgroundColor: Colors.red,
        ));
        return;
      }
      // creating user
      try {
        //checking if email already exists
        final userDoc = await FirebaseFirestore.instance
            .collection("Users")
            .doc(emailController.text)
            .get();

        if (userDoc.exists) {
          //email already in use
          //popping the loading indicator
          if (context.mounted) {
            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                "Email Already in use",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ));

            return;
          }
        }
        //if password is equal to confirm password create user
        if (passwordController.text == confirmPasswordController.text) {
          final authService = AuthService();

          //creating the user
          if (context.mounted) {
            UserCredential? userCredential =
                await authService.signUpWithEmailAndPassword(
                    context,
                    emailController.text,
                    passwordController.text,
                    usernameController.text);

            // create a user document and collect them in firestore.
            createUserDocument(userCredential);
            //clear the controllers.
            usernameController.clear();
            emailController.clear();
            passwordController.clear();
            confirmPasswordController.clear();

            //popping the loading indicator
            if (context.mounted) {
              Navigator.pop(context);
            }

            //show snackbar that account has been created successfully.
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                "Account created successfully",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              backgroundColor: Colors.green,
            ));
          }
        } else {
          //popping the loading indicator
          if (context.mounted) {
            Navigator.pop(context);
            //showing snackbar that passwords do not match
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text(
                "passwords do not match",
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              backgroundColor: Colors.red,
            ));
          }
        }
      } catch (e) {
        if (context.mounted) {
          //popping the loading indicator
          Navigator.pop(context);
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
                height: 50,
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
                    fontSize: 70,
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
              Text(
                "                         T H E     W A L L !",
                style: GoogleFonts.robotoCondensed(
                    fontSize: 30, fontWeight: FontWeight.bold),
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
