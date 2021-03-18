import 'package:flutter/material.dart';
import 'package:myhealthapp/models/comment.dart';
import 'package:myhealthapp/shared/constants.dart';
import 'package:myhealthapp/widgets/edit_comment.dart';
// import 'package:provider/provider.dart';

//import '../helpers/db_helper.dart';

class CommentDetailScreen extends StatelessWidget {
  final Comment commentDetails;
  CommentDetailScreen({this.commentDetails});
  static const routeName = '/comment-detail';

  @override
  Widget build(BuildContext context) {
    void _showEditCommentPanel() {
      showModalBottomSheet(
          context: context,
          builder: (context) {
            return SingleChildScrollView(
                          child: Container(
                height: 500,
                padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
                child: EditComment(
                    myComment:
                        commentDetails), //we pass down the index of widget.
              ),
            );
          });
    }

    //final id = ModalRoute.of(context).settings.arguments;
    //final selectedComment =
    //Provider.of<UserComments>(context, listen: false).findById(id);
    return Scaffold(
        appBar: AppBar(
          title: Text('News'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.edit),
              onPressed: () => _showEditCommentPanel(),
            ),
            IconButton(
              icon: Icon(
                Icons.delete,
              ),
              onPressed: () {
                //DBHelper.db.delete(comment.id);
              },
            )
          ],
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 350,
                width: double.infinity,
                child: Image.network(
                  '${commentDetails.image}',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
              ),
            ),
            SizedBox(
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.blue[100],
                height: 25,
                alignment: Alignment.topLeft,
                child: Text(
                  '${commentDetails.firstName}'
                  " "
                  '${commentDetails.lastName}\n\n',
                  textAlign: TextAlign.left,
                  style: userHeaders,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('${commentDetails.comment}'),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: FlatButton(
                onPressed: () {},
                child: Text(
                  'Enter comments',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            )
          ],
        ));
  }
}
