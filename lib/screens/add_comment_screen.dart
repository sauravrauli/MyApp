import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:myhealthapp/helpers/database.dart';
import 'package:myhealthapp/screens/view_news_screen.dart';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';
import 'users_comments.dart';

class AddCommentScreen extends StatefulWidget {
  static const routeName = '/add-comment';

  @override
  _AddCommentScreenState createState() => _AddCommentScreenState();
}

class _AddCommentScreenState extends State<AddCommentScreen> {
  final _titleController = TextEditingController();
  File _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _titleController.dispose();
    super.dispose();
  }

  void _savePlace() async {
    //   if (_titleController.text.isEmpty || _pickedImage == null) {
    //     return; //error messages or dialogue box can go here. e.g. showDialog.
    //   }

    final result = await _addComment(_titleController.text, _pickedImage);
    //Navigator.of(context).pop(true);
    Navigator.of(context).pop();
    //Navigator.of(context).popAndPushNamed(ViewNewsScreen.routeName);
    
  }

  Future<bool> _addComment(String text, File pickedImage) async {
    if (text == null || text.isEmpty) {
      return Future.value(false);
    }
    String pickedImageRemoteUrl;
    if (await pickedImage.exists()) {
      final ref = FirebaseStorage.instance.ref().child(
          DateTime.now().millisecondsSinceEpoch.toString());
      final task = ref.putFile(pickedImage);
      pickedImageRemoteUrl = await (await task.onComplete).ref.getDownloadURL();
      print(pickedImageRemoteUrl);
    }

    final user = await DBService().getCurrentUserDetails();

    Map<String, dynamic> data = {
      "comment": text,
      "dateTime": DateTime.now().millisecondsSinceEpoch.toString(),
      "firstName": user.firstName,
      "lastName": user.lastName,
      "uid": user.uid,
      "image": pickedImageRemoteUrl,
    };

    return Firestore.instance
        .collection('comments')
        .add(data)
        .then((_) => Future.value(true))
        .catchError((_) => Future.value(false));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.person_add,
              color: Colors.white,
            ),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(
              Icons.check_box,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Enter comments here:',
                      ),
                      controller: _titleController,
                      
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.send, color: Colors.white),
            label: Text(
              'Send Comment',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            onPressed: _savePlace,
            elevation: 0,
            materialTapTargetSize:
                MaterialTapTargetSize.shrinkWrap, //no space at bottom
            color: Theme.of(context).primaryColor, //set button color of theme.
          )
        ],
      ),
    );
  }
}
