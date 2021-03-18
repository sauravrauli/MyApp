import 'package:flutter/material.dart';

import 'package:myhealthapp/models/comment.dart';
import 'package:myhealthapp/screens/comment_detail_screen.dart';
import 'package:myhealthapp/shared/constants.dart';
import 'package:myhealthapp/shared/utility.dart';

import 'package:timeago/timeago.dart' as timeago;

class CommentTile extends StatefulWidget {
  final Comment commentInfo;
  CommentTile({this.commentInfo, ValueKey<String> key});

  @override
  _CommentTileState createState() => _CommentTileState();
}

class _CommentTileState extends State<CommentTile> {
  String photoUrl;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    getPhotoUrl(widget.commentInfo.photoUrl).then((value) => setState(() {
          photoUrl = value;
        }));
  }

  @override
  Widget build(BuildContext context) {
    final time = int.tryParse(widget.commentInfo.dateTime);

    String timeLabel;

    if (time != null) {
      timeLabel = timeago.format(DateTime.now().subtract(Duration(
          milliseconds: DateTime.now().millisecondsSinceEpoch - time)));
    } else {
      timeLabel = "";
    }
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Container(
        child: Card(
          color: Colors.blue[600],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          elevation: 7,
          margin: EdgeInsets.fromLTRB(15, 6, 15, 0),
          child: ListTile(
            leading: CircleAvatar(
                radius: 30.0,
                backgroundImage:
                    photoUrl != null ? NetworkImage(photoUrl) : null),
            title: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                '${widget.commentInfo.firstName}'
                " "
                '${widget.commentInfo.lastName}', //how do i make the first letter of name always CAPS?
                style: commentHeader,
              ),
            ),
            trailing: Container(
              width: 75,
              child: Text(
                timeLabel,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              alignment: Alignment.centerRight,
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 5),
              child: Text(
                '${widget.commentInfo.comment}.',
                style: commentTrailing,
              ),
            ),
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      CommentDetailScreen(commentDetails: widget.commentInfo),
                ),
              );
              //write CODE HERE TO PUSH TEAMDETAILSCREEN.
            },
          ),
        ),
      ),
    );
  }
}
