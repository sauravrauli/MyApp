// import 'dart:io';

// import 'package:flutter/foundation.dart';

// import '../models/comment.dart';
// import '../helpers/db_helper.dart';

// class UserComments with ChangeNotifier {
//   List<Comment> _comments = []; //comments = for the consumer build ctx.

//   List<Comment> get comments {
//     return [..._comments];
//   }

//   Comment findById(String id) {
//     return _comments.firstWhere((comment) => comment.id == id);
//   }

//   void addComment(
//     String pickedName,
//     File pickedImage,
//   ) {
//     final newComment = Comment(
//       id: DateTime.now().toString(),
//       userName: pickedName,
//       image: pickedImage,
//       dateTime: DateTime.now(),
//     );
//     _comments.add(newComment);
//     notifyListeners();
//     DBHelper.insert('user_comments', {
//       //connecting to db.
//       'id': newComment.id,
//       'userName': newComment.userName,
//       'image': newComment.image.path,
//     });
//   }

//   Future<void> fetchAndSetComments() async {
//     //6:41 Storing & fetching data with sql
//     final dataList = await DBHelper.getData('user_comments');
//     _comments = dataList
//         .map(
//           (comment) => Comment(
//             id: comment['id'],
//             userName: comment['userName'],
//             image: File(comment['image']),
//             dateTime: DateTime.now(),
//           ),
//         )
//         .toList();
//     notifyListeners();
//   }

//   void delete(int id,) {
//     _comments.remove(id);
//     notifyListeners();
    
//   }
// }
