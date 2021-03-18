// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myhealthapp/helpers/database.dart';
import 'package:myhealthapp/models/comment.dart';
import 'package:myhealthapp/screens/tabs_screen.dart';
import 'package:myhealthapp/screens/view_news_screen.dart';
// import 'package:myhealthapp/models/user.dart';
import 'package:myhealthapp/shared/constants.dart';
import 'package:myhealthapp/shared/loading.dart';
// import 'package:provider/provider.dart';

class EditComment extends StatefulWidget {
  final Comment myComment;
  EditComment({this.myComment});
  @override
  _EditCommentState createState() => _EditCommentState();
}

Future<FirebaseUser> getUser() async {
  FirebaseUser user = await FirebaseAuth.instance.currentUser();
  return user;
}

class _EditCommentState extends State<EditComment> {
  final _formKey = GlobalKey<FormState>();

  // form values
  String _currentComment;

  @override
  Widget build(BuildContext context) {
    //final user = Provider.of<User>(context);
    return FutureBuilder<FirebaseUser>(
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          String userId = snapshot.data.uid;
          final comment = widget.myComment;
          if (comment.uid == userId) {
            //print('$comment ');
            return Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Text(
                    'Edit your comment.',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  TextFormField(
                    initialValue: _currentComment ?? comment.comment,
                    decoration:
                        textInputDecoration.copyWith(hintText: 'Edit comment'),
                    validator: (val) => val.isEmpty ? '' : null,
                    onChanged: (val) => setState(() => _currentComment = val),
                  ),
                  SizedBox(height: 20),
                  RaisedButton(
                      child: Text(
                        'UPDATE COMMENT',
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                      color: Colors.blue,
                      onPressed: () async {
                        Navigator.of(context).pop();

                        if (_formKey.currentState.validate()) {
                          await FirebaseAuth.instance.currentUser();
                          await DBService(uid: userId).editComment(
                              _currentComment != null
                                  ? comment.copyWith(comment: _currentComment)
                                  : comment);

                          //print(_currentComment);
                        }
                         Navigator.of(context)
                            .popAndPushNamed(TabsScreen().uid);
                      })
                ],
              ),
            );
          } else {
            return Text('Cannot update this comment');
          }
        } else {
          return Loading();
        }
      },
      future: getUser(),
    );
  }
}
