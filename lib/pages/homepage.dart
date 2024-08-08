import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:social_medial_app/components/wall_drawer.dart';
import 'package:social_medial_app/components/wall_list_tile.dart';
import 'package:social_medial_app/components/wall_textField.dart';
import 'package:social_medial_app/database/firestore_database.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    //create firebase database instance.
    FirestoreDatabase database = FirestoreDatabase();

    //post controller
    TextEditingController postController = TextEditingController();

    //post  a message.
    void postMessage() {
      //only post a message, if there is something in the textfield
      if (postController.text.isNotEmpty) {
        String message = postController.text;
        database.addPost(message);
      }
      //clear the controller
      postController.clear();
    }

    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          title: const Center(
              child: Text(
            'The Wall',
            style: TextStyle(fontWeight: FontWeight.bold),
          )),
        ),
        drawer: const WallDrawer(),
        body: Column(
          children: [
            //input field for adding post
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    width: 10,
                    child: WallTextfield(
                        hintText: "Type your post here ..",
                        obscureText: false,
                        controller: postController),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: ElevatedButton(
                        onPressed: postMessage,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                        ),
                        child: Icon(
                          Icons.done,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ))),
              ],
            ),

            // expanded widgets for all the posts.
            StreamBuilder(
                stream: database.getPostsStream(),
                builder: (context, snapshot) {
                  //show loading circle
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  //get all posts
                  final posts = snapshot.data!.docs;

                  //if no data
                  if (snapshot.data == null || posts.isEmpty) {
                    return const Center(
                        child: Padding(
                      padding: EdgeInsets.all(25),
                      child: Text("No posts yet ......"),
                    ));
                  }

                  // return as a list
                  return Expanded(
                    child: ListView.builder(
                        itemCount: posts.length,
                        itemBuilder: (context, index) {
                          //get each individual post
                          final post = posts[index];

                          //get data from each post.
                          String message = post['PostMessage'];
                          String userEmail = post['UserEmail'];
                          Timestamp timestamp = post['TimeStamp'];

                          return WallListTile(
                              title: message, subtitle: userEmail);
                        }),
                  );
                })
          ],
        ));
  }
}
