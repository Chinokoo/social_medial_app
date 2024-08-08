import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase {
  //current logged in user
  User? user = FirebaseAuth.instance.currentUser;

  //get a collection of posts from firebase
  final CollectionReference posts =
      FirebaseFirestore.instance.collection("Posts");

  //post a post.
  Future<void> addPost(String message) {
    return posts.add({
      'UserEmail': user!.email,
      'PostMessage': message,
      "TimeStamp": Timestamp.now(),
    });
  }

  //read a post from a database.
  Stream<QuerySnapshot> getPostsStream() {
    final postsStream = FirebaseFirestore.instance
        .collection("Posts")
        .orderBy("TimeStamp", descending: true)
        .snapshots();
    return postsStream;
  }
}
