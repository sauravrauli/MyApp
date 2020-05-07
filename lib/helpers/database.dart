import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myhealthapp/models/comment.dart';
import 'package:myhealthapp/models/user.dart';

class DBService {
  final String uid;

  DBService({this.uid});
  //create instance of comments collection.
  final CollectionReference userComments =
      Firestore.instance.collection('comments');

  //create +add field in collection for a comment.
  Future updateCommentData(String firstName, String lastName, String comment,
      image, String dateTime) async {
    return await userComments.document(uid).setData({
      'uid': uid, //this prints our our firebase uid in collection.
      'firstName': firstName,
      'lastName': lastName,
      'comment': comment,
      'image': image,
      'dateTime': dateTime,
    });
  }

  //create instance of user collection. *ADD MOBILE no.*
  final CollectionReference userData = Firestore.instance.collection('users');
  //create +add field in collection for a user. (*NEED TO SORT OUT: when i call this updateUserData function it makes password null, i.e. might have to create a new method inputDataInDB, and updateUserData)
  Future updateUserData(String firstName, String lastName, String email,
      String password, String dateOfBirth, String photoUrl) async {
    return await userData.document(uid).setData({
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'dateOfBirth': dateOfBirth,
      'photoUrl' : photoUrl
    });
  }

  Future<User> getCurrentUserDetails() async {
    final userId = (await FirebaseAuth.instance.currentUser()).uid;
      return userData.document(userId).get().then((value) {
          return User.fromMap(value.data);
       });
  }

//comment list from snapshot,??
  List<Comment> _commentListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) {
      return Comment(
        uid: doc.data['user.uid'],
        firstName: doc.data['firstName'] ?? '',
        lastName: doc.data['lastName'] ?? '',
        comment: doc.data['comment'] ?? '',
        image: doc.data['image'] ?? '',
        dateTime: doc.data['dateTime'] ?? '',
      );
    }).toList();
  }

  User _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return User(
        uid: uid,
        firstName: snapshot.data['firstName'],
        lastName: snapshot.data['lastName'],
        email: snapshot.data['email']);
  }
  //user list from snapshot 
  List<User>_userListFromSnapshot(QuerySnapshot snapshot){
    return snapshot.documents.map((doc){
      return User(
        uid: doc.data['user.uid'],
        firstName: doc.data['firstName'],
        lastName: doc.data['lastName'],
        email: doc.data['email'],
        );
    }).toList();
  }

//get comments stream
  Stream<List<Comment>> get comments {
    return userComments.snapshots().map(_commentListFromSnapshot);
  }

//get user doc stream
  Stream<User> get usersData {
    return userData.document(uid).snapshots().map(_userDataFromSnapshot);
  }
//get all users doc stream
  Stream<List<User>> get getAllUsers{
    return userData.snapshots().map(_userListFromSnapshot);
  }
}
