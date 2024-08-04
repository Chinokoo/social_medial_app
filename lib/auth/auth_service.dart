import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../errors/error_handler.dart';

String getErrorMessage(String errorCode) {
  switch (errorCode) {
    case 'user-not-found':
      return 'No user found for that email.';
    case 'wrong-password':
      return 'Wrong password provided.';
    case 'invalid-email':
      return 'The email address is badly formatted.';
    case 'user-disabled':
      return 'This user account has been disabled.';
    case 'email-already-in-use':
      return 'The email address is already in use by another account.';
    case 'operation-not-allowed':
      return 'Email/password accounts are not enabled.';
    case 'weak-password':
      return 'The password provided is too weak.';
    default:
      return 'An error occurred. Please try again.';
  }
}

//class for authentication service
class AuthService {
  //instance of firebase auth
  FirebaseAuth auth = FirebaseAuth.instance;

  //sign in with email and password method.
  Future<UserCredential?> signInWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    //try to sign in with email and password
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      String errorMessage = getErrorMessage(e.code);
      ErrorHandler.showError(context, errorMessage);
      return null;
    } catch (e) {
      ErrorHandler.showError(context, 'An error occurred. Please try again.');
      return null;
    }
  }

  //sign up method.
  Future<UserCredential?> signUpWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    //try to create a new user with email and password.
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      return userCredential;
    } on FirebaseAuthException catch (e) {
      String errorMessage = getErrorMessage(e.code);
      ErrorHandler.showError(context, errorMessage);
      return null;
    } catch (e) {
      ErrorHandler.showError(context, 'An error occurred. Please try again.');
      return null;
    }
  }

  //sign out method.
  Future<void> signOut() async {
    await auth.signOut();
  }
}
