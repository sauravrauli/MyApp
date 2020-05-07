// import 'package:flutter/foundation.dart';
// import 'dart:io';
// import 'dart:convert';

// Comment commentFromJson(String str) {
//   final jsonData = json.decode(str);
//   return Comment.fromMap(jsonData);
// }

// String commentToJson(Comment data) {
//   final dyn = data.toMap();
//   return json.encode(dyn);
// }

class Comment {
  //final String uid;
  final String uid;
  final String firstName;
  final String lastName;
  final String comment;
  final String image;
  final String dateTime;

  Comment({
    // @required this.uid,
    this.uid,
    this.firstName,
    this.lastName,
    this.comment,
    this.image,
    this.dateTime,
  });
}
//   factory Comment.fromMap(Map<String, dynamic> json) => new Comment(
//         uid: json["uid"],
//         userName: json["userName"],
//         image: json["image"],
//         dateTime: json["dateTime"],
//       );

//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "userName": userName,
//         "image": image,
//         "dateTime": dateTime,
//       };
