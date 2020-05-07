//import 'dart:convert';
//import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:myhealthapp/models/comment.dart';
import 'comment_tile.dart';
// import '../helpers/database.dart';
// import 'package:myhealthapp/providers/auth2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UsersComments extends StatefulWidget {
  @override
  _UsersCommentsState createState() => _UsersCommentsState();
}

getUser() async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  debugPrint('User: ${user.uid}');
}

class _UsersCommentsState extends State<UsersComments> {
  @override
  Widget build(BuildContext context) {
    final comments = Provider.of<List<Comment>>(context) ?? [];
    // debugPrint("Testing");
    // FirebaseUser user =  getUser();
    // final service = DBService(uid: user.uid);
    // final list =  service.comments.toList();

    return ListView.builder(
      itemCount: comments.length,
      itemBuilder: (context, index) {
        final comment = comments[index];
        return Dismissible(
            onDismissed: (direction) {
              setState(() {
                comments.removeAt(index);
              });
              Scaffold.of(context)
                  .showSnackBar(SnackBar(content: Text("$comment dismissed")));
            },
            background: Container(
              color: Colors.red,
            ),
            key: Key(comment.toString()),
            child: CommentTile(comment: comments[index]));
      },
    );
  }
}
