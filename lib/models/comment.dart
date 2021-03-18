import 'dart:convert';

import 'package:flutter/foundation.dart';

@immutable
class Comment {
  //final String uid;
  final String docId;
  final String uid;
  final String firstName;
  final String lastName;
  final String comment;
  final String image;
  final String dateTime;
  final String photoUrl;

  const Comment({
    this.docId,
    this.uid,
    this.firstName,
    this.lastName,
    this.comment,
    this.image,
    this.dateTime,
    this.photoUrl,
  });

  Comment copyWith({
    String docId,
    String uid,
    String firstName,
    String lastName,
    String comment,
    String image,
    String dateTime,
    String photoUrl,
  }) {
    return Comment(
      docId: docId ?? this.docId,
      uid: uid ?? this.uid,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      comment: comment ?? this.comment,
      image: image ?? this.image,
      dateTime: dateTime ?? this.dateTime,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'docId': docId,
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'comment': comment,
      'image': image,
      'dateTime': dateTime,
      'photoUrl': photoUrl,
    };
  }

  static Comment fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Comment(
      docId: map['docId'],
      uid: map['uid'],
      firstName: map['firstName'],
      lastName: map['lastName'],
      comment: map['comment'],
      image: map['image'],
      dateTime: map['dateTime'],
      photoUrl: map['photoUrl'],
    );
  }

  String toJson() => json.encode(toMap());

  static Comment fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Comment(docId: $docId, uid: $uid, firstName: $firstName, lastName: $lastName, comment: $comment, image: $image, dateTime: $dateTime, photoUrl: $photoUrl)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Comment &&
        o.docId == docId &&
        o.uid == uid &&
        o.firstName == firstName &&
        o.lastName == lastName &&
        o.comment == comment &&
        o.image == image &&
        o.dateTime == dateTime &&
        o.photoUrl == photoUrl;
  }

  @override
  int get hashCode {
    return docId.hashCode ^
        uid.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        comment.hashCode ^
        image.hashCode ^
        dateTime.hashCode ^
        photoUrl.hashCode;
  }
}
