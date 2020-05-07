import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myhealthapp/models/comment.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentTile extends StatelessWidget {
  final Comment comment;
  CommentTile({this.comment});

  @override
  Widget build(BuildContext context) {
    final time = int.tryParse(comment.dateTime);
    String timeLabel;
    final dateFormat = DateFormat('EEE, M/d/y HH:mm a');
    if (time != null) {
      timeLabel = dateFormat.format(DateTime.fromMillisecondsSinceEpoch(time));
    } else {
      timeLabel = "";
    }
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: Stack(children: <Widget>[
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(comment.image),
              radius: 30.0,
              backgroundColor: Colors.brown,
            ),
            title: Text(
              '${comment.firstName}'
              " "
              '${comment.lastName}', //how do i make the first letter of name always CAPS?
              style: TextStyle(fontSize: 23, letterSpacing: 1.0),
            ),
            trailing: Container(
              color: Colors.red,
              width: 75,
              child: Text(timeLabel),
              alignment: Alignment.centerRight,
            ),
            subtitle: Text('${comment.comment}.'),
          ),
        ]),
      ),
    );
  }
}
