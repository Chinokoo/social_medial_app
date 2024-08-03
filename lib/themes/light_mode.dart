import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.white,
    primary: Colors.grey.shade200,
    secondary: Colors.grey.shade700,
    inversePrimary: Colors.black,
  ),
);
