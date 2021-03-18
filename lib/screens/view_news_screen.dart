//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:myhealthapp/shared/loading.dart';
// import 'package:provider/provider.dart';

//import 'package:myhealthapp/providers/user_comments.dart';
import './add_comment_screen.dart';
import 'package:myhealthapp/screens/users_comments.dart';
//import './comment_detail_screen.dart';
//import '../helpers/db_helper.dart';
import '../models/comment.dart';
import 'package:myhealthapp/helpers/database.dart';
//import 'package:myhealthapp/models/user.dart';

class ViewNewsScreen extends StatelessWidget {
  final String uid;

  ViewNewsScreen({this.uid});

  static const routeName = '/news-feed';
  //ViewNewsScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Comment>>(
        //StreamProvider creates the CommentsTile.
        stream: DBService(uid: uid).comments,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Comment> userComments = snapshot.data;

            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Container(
                  // decoration: new BoxDecoration(
                  //   color: Colors.lightBlue[100],
                  //   gradient: new LinearGradient(
                  //     colors: [Colors.blue, Colors.white],
                  //     begin: Alignment.topCenter,
                  //     end: Alignment.bottomCenter,
                  //   ),
                  // ),
                  child: UsersComments(uid: uid, commentData: userComments)),
              floatingActionButton: FloatingActionButton.extended(
                onPressed: () {
                  Navigator.of(context).pushNamed(AddCommentScreen.routeName);
                },
                label: Text('Create Post',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w900)),
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                backgroundColor: Colors.blue,
              ),
            );
          } else {
            return Center(
              child: Text(
                'No comments have been added as of yet.',
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Avenir',
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }
        });
  }
}
// body: FutureBuilder(
//   future: Provider.of<UserComments>(context, listen: false)
//       .fetchAndSetComments(), //load data
//   builder: (ctx, snapshot) => snapshot.connectionState ==
//           ConnectionState.waiting
//       ? Center(
//           child: CircularProgressIndicator(),
//         )
//       : Consumer<UserComments>(
//           child: Center(
//             child: const Text('No Comments'),
//           ),
//           builder: (ctx, userComments, ch) =>
//               userComments.comments.length <= 0
//                   ? ch
//                   : ListView.builder(
//                       itemCount: userComments.comments.length,
//                       itemBuilder: (ctx, i) {
//                         Comment comment = userComments.comments[i];
//                         return Dismissible(
//                           background: Container(
//                             color: Theme.of(context).errorColor,
//                             child: Icon(
//                               Icons.delete,
//                               color: Colors.white,
//                               size: 40,
//                             ),
//                             alignment: Alignment.centerRight,
//                             padding: EdgeInsets.only(right: 20),
//                             margin: EdgeInsets.symmetric(
//                               horizontal: 15,
//                               vertical: 4,
//                             ),
//                           ),
//                           direction: DismissDirection.endToStart,
//                           key: UniqueKey(),
//                           onDismissed: (direction) {
//                             //call the remove comment.
//                             DBHelper.db.delete(comment.id);
//                           },
//                           child: ListTile(
//                             leading: CircleAvatar(
//                               backgroundColor: Colors.brown.shade800,
//                               child: Text('SR'),

//                               //backgroundImage: FileImage(
//                               //userComments.comments[i].image,
//                               //), //this is so it uploads image in icon.
//                             ),
//                             title:
//                                 Text(userComments.comments[i].userName),
//                             onTap: () {
//                               Navigator.of(context).pushNamed(
//                                 CommentDetailScreen.routeName,
//                                 arguments: userComments.comments[i].id,
//                               );
//                               //go to detail page...
//                             },
//                           ),
//                         );
//                       }),
//         ),
// ),
