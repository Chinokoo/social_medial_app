import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:social_medial_app/components/wall_back_button.dart';

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
                    Row(
                      children: [
                        WallBackButton(
                            onTap: () =>
                                Navigator.pushNamed(context, '/home_page'))
                      ],
                    ),
                    const SizedBox(
                      height: 100,
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      child: Icon(
                        Icons.person_2_rounded,
                        size: 100,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    Text(
                      user?['email'] ?? "no mail",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      user?['username'] ?? "no username",
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontSize: 16),
                    ),
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
