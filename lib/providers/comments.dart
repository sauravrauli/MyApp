import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../models/comment.dart';

class Comments with ChangeNotifier {
  List<Comment> _comments = []; //comments = for the consumer build ctx.

  List<Comment> get comments {
    return [..._comments];
  }

  Comment findById(String id) {
    return _comments.firstWhere((comment) => comment.id == id);
  }

  // Future<void> fetchAndSetComments() async {
  //   const url = 'https://myhe-7df66.firebaseio.com/usercomments.json';
  //   try {
  //     final response = await http.get(url);
  //     final extractedData = json.decode(response.body) as Map<String, dynamic>;
  //     if (extractedData == null) {
  //       return;
  //       }
  //     final List<Comment> loadedComments = [];
  //     extractedData.forEach((commentId, commentData){
  //       loadedComments.add(Comment(
  //           id: commentId,
  //           userName: commentData['userName'],
  //           image: File(commentData['image'],),
  //           dateTime: DateTime.now(),
  //         ));
  //     });
  //     _comments = loadedComments;
  //   notifyListeners();
  // }

  void addComment(String commentId, String pickedName, File pickedImage) {
    const url = 'https://myhe-7df66.firebaseio.com/usercomments.json';
    http.post(url, body: json.encode({
        'id': commentId,
        'userName': pickedName,
        'image': pickedImage,
      }),
    );
    final newComment = Comment(
      id: commentId,
      userName: pickedName,
      image: pickedImage,
      dateTime: DateTime.now(),
    );
    _comments.add(newComment);
    notifyListeners();
  }

  void delete(
    int id,
  ) {
    _comments.remove(id);
    notifyListeners();
  }
}
