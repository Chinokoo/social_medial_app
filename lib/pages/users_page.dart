import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Users"),
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Users").snapshots(),
          builder: (context, snapshot) {
            //any errors
            if (snapshot.hasError) {
              Text("Something went wrong! ${snapshot.error}");
            }
            //show loading circle
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            //get all users from firestore
            final users = snapshot.data!.docs;

            //build list of users
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                //get individual user
                final user = users[index];

                //build user list tile
                return ListTile(
                  title: Text(user["username"]),
                  subtitle: Text(user["email"]),
                );
              },
            );
          },
        ));
  }
}
