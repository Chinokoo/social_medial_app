import 'package:flutter/material.dart';

class WallBackButton extends StatelessWidget {
  final Function()? onTap;
  const WallBackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        margin: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Theme.of(context).colorScheme.primary),
        child: Icon(
          Icons.arrow_back,
          size: 25,
          color: Theme.of(context).colorScheme.inversePrimary,
        ),
      ),
    );
  }
}
