//import 'dart:convert';
//import 'dart:io';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:myhealthapp/helpers/database.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:provider/provider.dart';
import 'package:myhealthapp/models/comment.dart';
import 'comment_tile.dart';
// import '../helpers/database.dart';
// import 'package:myhealthapp/providers/auth2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UsersComments extends StatefulWidget {
  final String uid;
  final List<Comment> commentData;
  UsersComments({this.uid, this.commentData});

  @override
  _UsersCommentsState createState() => _UsersCommentsState();
}

Future<FirebaseUser> getUser() async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  return user;
}

class _UsersCommentsState extends State<UsersComments> {
  @override
  Widget build(BuildContext context) {
    //final comments = Provider.of<List<Comment>>(context) ?? [];
    // debugPrint("Testing");
    // FirebaseUser user =  getUser();
    // final service = DBService(uid: user.uid);
    // final list =  service.comments.toList();

    //print('userId = $userId');
    return ListView.builder(
        itemCount: widget.commentData.length,
        itemBuilder: (context, index) {
          final comment = widget.commentData[index];
          if (comment.uid == widget.uid) {
            print('index $index dismissable for ${comment.uid}');
            return Dismissible(
              direction: DismissDirection.endToStart,
              confirmDismiss: (direction) async {
                return showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Are you sure?'),
                    content: Text(
                      'Are you sure you want to delete this post?',
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('NO'),
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                      ),
                      FlatButton(
                        child: Text('YES'),
                        onPressed: () async {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Your post has been deleted."),
                            ),
                          );
                          await DBService().deleteComment(comment);
                          Navigator.of(ctx).pop(true);
                        },
                      )
                    ],
                  ),
                );

                // setState(() {
                //   comments.removeAt(index);
                // });
              },
              background: Container(
                color: Colors.red,
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 40,
                ),
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 25),
                margin: EdgeInsets.fromLTRB(20, 13, 20, 0),
              ),
              key: ValueKey(comment.docId),
              child: CommentTile(
                commentInfo: widget.commentData[index],
              ),
            );
          } else {
            return CommentTile(
                commentInfo: widget.commentData[index],
                key: ValueKey(comment.docId));
          }
        });
  }
}
