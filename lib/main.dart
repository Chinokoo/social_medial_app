import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:social_medial_app/auth/auth_page.dart';
import 'package:social_medial_app/auth/login_or_registerPage.dart';
import 'package:social_medial_app/themes/dark_mode.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

Future<void> main() async {
  //initializing dotenv
  await dotenv.load(fileName: '.env');

  //initializing firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkMode,
      home: const Scaffold(
        body: AuthPage(),
      ),
    );
  }
}
