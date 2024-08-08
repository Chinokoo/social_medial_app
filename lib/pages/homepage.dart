import 'package:flutter/material.dart';
import 'package:social_medial_app/components/wall_drawer.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('The Wall'),
      ),
      drawer: WallDrawer(),
      body: Center(
        child: Text('Welcome to Social Media App'),
      ),
    );
  }
}
