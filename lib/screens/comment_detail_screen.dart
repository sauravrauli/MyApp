import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_comments.dart';

class CommentDetailScreen extends StatelessWidget {
  static const routeName = '/comment-detail';

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context).settings.arguments;
    final selectedComment =
        Provider.of<UserComments>(context, listen: false).findById(id);
    return Scaffold(
        appBar: AppBar(
          title: Text('News'),
        ),
        body: Column(
          children: <Widget>[
            Container(
              height: 250,
              width: double.infinity,
              child: Image.file(
                selectedComment.image,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
            SizedBox(height: 10,),
            Text(selectedComment.userName, textAlign: TextAlign.left,)
          ],
        ));
  }
}
