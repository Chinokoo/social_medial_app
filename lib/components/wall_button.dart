import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class WallButton extends StatelessWidget {
  final Function()? onTap;
  final String buttonText;
  const WallButton({super.key, required this.buttonText, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 25),
        margin: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Theme.of(context).colorScheme.primary,
        ),
        child: Center(
          child: Text(buttonText,
              style: GoogleFonts.azeretMono(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.inversePrimary,
              )),
        ),
      ),
    );
  }
}
