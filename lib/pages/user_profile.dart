import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  UserProfile({super.key});

  final User? currentUser = FirebaseAuth.instance.currentUser;

  //future method to fetch user details.
  Future<DocumentSnapshot<Map<String, dynamic>>> getUserDetails() async {
    return await FirebaseFirestore.instance
        .collection("Users")
        .doc(currentUser!.email)
        .get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("User Profile"),
      ),
      body: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          future: getUserDetails(),
          builder: (context, snapshot) {
            //loading ..
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            //error
            else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error} ");
            }
            //data received.
            else if (snapshot.hasData) {
              //extract data
              Map<String, dynamic>? user = snapshot.data!.data();

              return Center(
                child: Column(
                  children: [
                    Text(user?['email'] ?? "no mail"),
                    Text(user?['username'] ?? "no username"),
                  ],
                ),
              );
            } else {
              return const Text("No user found");
            }
          }),
    );
  }
}
