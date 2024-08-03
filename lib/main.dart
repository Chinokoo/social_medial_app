import 'package:flutter/material.dart';
import 'package:social_medial_app/auth/login_or_registerPage.dart';
import 'package:social_medial_app/themes/light_mode.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';

Future<void> main() async {
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
      theme: lightMode,
      home: const Scaffold(
        body: LoginOrRegisterpage(),
      ),
    );
  }
}
