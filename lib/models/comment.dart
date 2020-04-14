import 'package:flutter/foundation.dart';
import 'dart:io';
import 'dart:convert';

Comment commentFromJson(String str) {
  final jsonData = json.decode(str);
  return Comment.fromMap(jsonData);
}

String commentToJson(Comment data) {
  final dyn = data.toMap();
  return json.encode(dyn);
}

class Comment {
  final String id;
  final String userName;
  final DateTime dateTime;
  final File image;

  Comment({
    @required this.id,
    @required this.userName,
    @required this.dateTime,
    @required this.image,
  });

  factory Comment.fromMap(Map<String, dynamic> json) => new Comment(
        id: json["id"],
        userName: json["userName"],
        image: json["image"],
        dateTime: json["dateTime"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "userName": userName,
        "image": image,
        "dateTime": dateTime,
      };
}






