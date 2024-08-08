import 'package:flutter/material.dart';

class WallListTile extends StatelessWidget {
  final String title;
  final String subtitle;
  const WallListTile({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      child: ListTile(
        title: Text(title),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary),
        ),
      ),
    );
  }
}
