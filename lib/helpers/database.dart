import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:myhealthapp/models/comment.dart';
import 'package:myhealthapp/models/user.dart';
import 'package:myhealthapp/models/shifts.dart';
//import 'package:myhealthapp/screens/add_shift_screen.dart';

class DBService {
  final String uid;

  DBService({this.uid});
  //create instance of comments collection.
  final CollectionReference userComments =
      Firestore.instance.collection('comments');

  //create +add field in collection for a comment.
  Future updateCommentData(String firstName, String lastName, String comment,
      image, String dateTime, String photoUrl) async {
    return await userComments.document(uid).setData({
      'uid': uid, //this prints our our firebase uid in collection.
      'firstName': firstName,
      'lastName': lastName,
      'comment': comment,
      'image': image,
      'dateTime': dateTime,
      'photoUrl': photoUrl,
    });
  }

  //create instance of user collection. *ADD MOBILE no.*
  final CollectionReference userData = Firestore.instance.collection('users');
  //create +add field in collection for a user. (*NEED TO SORT OUT: when i call this updateUserData function it makes password null, i.e. might have to create a new method inputDataInDB, and updateUserData)
  Future updateUserData(
      String firstName,
      String lastName,
      String email,
      String password,
      String dateOfBirth,
      String photoUrl,
      String phoneNo) async {
    return await userData.document(uid).setData({
      //i changed it from setData to => updateData
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'dateOfBirth': dateOfBirth,
      'photoUrl': photoUrl,
      'phoneNo': phoneNo,
      'isAdmin': false,
    });
  }

  Future editProfileData(
      String firstName,
      String lastName,
      String email,
      String password,
      String dateOfBirth,
      String photoUrl,
      String phoneNo) async {
    return await userData.document(uid).updateData({
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'dateOfBirth': dateOfBirth,
      'photoUrl': photoUrl,
      'phoneNo': phoneNo,
    });
  }

  Future updateShiftData(
      String firstName, String lastName, String dateTime) async {
    return await shiftData.document(uid).setData({
      'uid': uid,
      'firstName': firstName,
      'lastName': lastName,
      'time': dateTime,
    });
  }

  // Shift _shiftDataFromSnapshot(DocumentSnapshot snapshot) {
  //   return Shift.fromDoc(snapshot);
  // }

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
        docId: doc.documentID,
        uid: doc.data['uid'],
        firstName: doc.data['firstName'] ?? '',
        lastName: doc.data['lastName'] ?? '',
        comment: doc.data['comment'] ?? '',
        image: doc.data['image'] ?? '',
        dateTime: doc.data['dateTime'] ?? '',
        photoUrl: doc.data['photoUrl'] ??
            'https://img.icons8.com/pastel-glyph/2x/person-male.png',
      );
    }).toList();
  }

  Future<void> deleteComment(Comment comment) async {
    return userComments.document(comment.docId).delete();
  }

  Future<void> editComment(Comment comment) async {
    return await userComments
        .document(comment.docId)
        .updateData(comment.toMap()); //NEED TO FIX THIS
  }

  User _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return User.fromMap(snapshot.data);
  }

  //user list from snapshot
  List<User> _userListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) => User.fromMap(doc.data)).toList();
  }

  //shift data from snapshot
  List<Shift> _shiftListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.documents.map((doc) => Shift.fromMap(doc.data)).toList();
  }

//get comments stream
  Stream<List<Comment>> get comments {
    return userComments
        .orderBy("dateTime", descending: true)
        .snapshots()
        .map(_commentListFromSnapshot);
  }

//get user doc stream
  Stream<User> get usersData {
    return userData.document(uid).snapshots().map(_userDataFromSnapshot);
  }

//get all users doc stream
  Stream<List<User>> get getAllUsers {
    return userData
    .orderBy("isAdmin", descending: true)
    .orderBy('firstName').snapshots().map(_userListFromSnapshot);
  }

  //get one comment
  // Stream<List<Comment>> get comment{
  //   return userComments.document(uid).snapshots().map(_commentListFromSnapshot)
  // }

  //create instance of shift collection.
  final CollectionReference shiftData = Firestore.instance.collection('shift');

  Stream<List<Shift>> get shifts {
    return shiftData.snapshots().map(_shiftListFromSnapshot);
  }

  Stream<List<Shift>> get userShifts {
    return shiftData
        .where("uid", isEqualTo: uid)
        .orderBy("Date")
        .orderBy("Time")
        .snapshots()
        .map((querySnapshot) =>
            querySnapshot.documents.map((doc) => Shift.fromDoc(doc)).toList());
  }

  Stream<List<MapEntry<String, Shift>>> get pendingShifts {
    return shiftData
    .where("isApproved", isEqualTo: getShiftStatusValue(ShiftStatus.none),)
     //.orderBy("Time")
        .snapshots()
        .map((querySnapshot) =>
            querySnapshot.documents.map((doc) => MapEntry(doc.documentID, Shift.fromDoc(doc))).toList());
  }

  Future updateShift(String shiftId, Shift shift) {
    return shiftData.document(shiftId).updateData(shift.toMap());
  }

  Future updateShiftMap(String shiftId, Map data) {
    return shiftData.document(shiftId).updateData(data);
  }

    Future<void> deleteShift(Shift shift) async {
    return shiftData.document(shift.shiftId).delete();
  }

 Stream<List<MapEntry<String, Shift>>> get availableShifts {
    return shiftData.where("Add Employee", isEqualTo: "Open Shift")
    .snapshots()
     .map((querySnapshot) =>
            querySnapshot.documents.map((doc) => MapEntry(doc.documentID, Shift.fromDoc(doc))).toList());
    
  }
}
