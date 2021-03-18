import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image/image.dart' as CoreImage;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myhealthapp/helpers/database.dart';
import 'package:myhealthapp/models/user.dart';
import 'package:myhealthapp/shared/constants.dart';
import 'package:myhealthapp/shared/loading.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:myhealthapp/shared/utility.dart';

class SettingsForm extends StatefulWidget {
  @override
  _SettingsFormState createState() => _SettingsFormState();
}

class _SettingsFormState extends State<SettingsForm> {
  final _formKey = GlobalKey<FormState>();

//form values
  String _currentFirstName;
  String _currentLastName;
  String _currentEmail;
  String _currentPassword;
  String _currentDateOfBirth;
  String _currentPhoneNo;

  File _pickedFile;

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Profile Settings'),
      ),
      body: StreamBuilder<User>(
        stream: DBService(uid: user.uid)
            .usersData, //calls the usersData getter, stream in DBService.
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User userData = snapshot.data;
            return SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        'Change Your Details Below:',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Center(
                        child: Container(
                          width: 150,
                          height: 150,
                          child: GestureDetector(
                            onTap: () {
                              _showBottomSheetForSelectingMediaSource(context);
                            },
                            child: FutureBuilder(
                              future: getPhotoUrl(userData.image),
                              builder: (ctx, snapshot) {
                                if (snapshot.hasData) {
                                  return CircleAvatar(
                                    radius: 75,
                                    backgroundImage: _pickedFile == null
                                        ? NetworkImage(snapshot.data)
                                        : FileImage(_pickedFile),
                                    backgroundColor: Colors.blue[100],
                                  );
                                } else {
                                  return Loading();
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 25),
                      Text(
                        'First Name:',
                        style: TextStyle(fontSize: 15),
                      ),
                      TextFormField(
                        initialValue: userData.firstName,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'First Name'),
                        validator: (val) =>
                            val.isEmpty ? 'Enter a first name' : null,
                        onChanged: (val) =>
                            setState(() => _currentFirstName = val),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Last Name:',
                        style: TextStyle(fontSize: 15),
                      ),
                      TextFormField(
                        initialValue: userData.lastName,
                        textCapitalization: TextCapitalization.sentences,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Last Name'),
                        validator: (val) =>
                            val.isEmpty ? 'Enter a last name' : null,
                        onChanged: (val) =>
                            setState(() => _currentLastName = val),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Email:',
                        style: TextStyle(fontSize: 15),
                      ),
                      TextFormField(
                        initialValue: userData.email,
                        textCapitalization: TextCapitalization.sentences,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (val) =>
                            val.isEmpty ? 'Enter a email' : null,
                        onChanged: (val) => setState(() => _currentEmail = val),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'DOB:',
                        style: TextStyle(fontSize: 15),
                      ),
                      TextFormField(
                        initialValue: userData.dateOfBirth,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'DD/MM/YYYY'),
                        validator: (val) => val.isEmpty ? 'Enter a DOB' : null,
                        onChanged: (val) =>
                            setState(() => _currentDateOfBirth = val),
                      ),
                      SizedBox(height: 20),
                      Text(
                        'Phone no.',
                        style: TextStyle(fontSize: 15),
                      ),
                      TextFormField(
                        initialValue: userData.phoneNo,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: textInputDecoration.copyWith(
                            hintText: '+44 000 000 000'),
                        validator: (val) =>
                            val.isEmpty ? 'Enter a phone number' : null,
                        onChanged: (val) =>
                            setState(() => _currentPhoneNo = val),
                      ),
                      SizedBox(height: 20),
                      Center(
                        child: RaisedButton(
                          color: Colors.blue,
                          child: Text(
                            'Update',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            Future<void> _showMyDialog(
                                BuildContext context) async {
                              return showDialog<void>(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Change your settings?"),
                                      content: Text(
                                          "Are you sure you want to change your settings?"),
                                      actions: <Widget>[
                                        FlatButton(
                                          child: Text('Yes'),
                                          onPressed: () async {
                                            if (_formKey.currentState
                                                .validate()) {
                                              String pickedImageRemoteUrl;
                                              if (_pickedFile != null &&
                                                  await _pickedFile.exists()) {
                                                final ref = FirebaseStorage
                                                    .instance
                                                    .ref()
                                                    .child(user.uid);
                                                final task =
                                                    ref.putFile(_pickedFile);

                                                pickedImageRemoteUrl =
                                                    (await task.onComplete)
                                                        .storageMetadata
                                                        .path;

                                                print(pickedImageRemoteUrl);
                                              }

                                              UserUpdateInfo userUpdateInfo =
                                                  UserUpdateInfo();
                                              userUpdateInfo.photoUrl =
                                                  pickedImageRemoteUrl;

                                              await (await FirebaseAuth.instance
                                                      .currentUser())
                                                  .updateProfile(
                                                      userUpdateInfo);

                                              await DBService(uid: user.uid)
                                                  .editProfileData(
                                                //need a new function here, as this updates all fields and i am not changing password/DOB here.
                                                _currentFirstName ??
                                                    userData.firstName,
                                                _currentLastName ??
                                                    userData.lastName,
                                                _currentEmail ?? userData.email,
                                                _currentPassword ??
                                                    userData.password,
                                                _currentDateOfBirth ??
                                                    userData.dateOfBirth,
                                                pickedImageRemoteUrl ??
                                                    userData.image,
                                                _currentPhoneNo ??
                                                    userData.phoneNo,

                                                //TODO: fix this later
                                              );
                                              // print(_currentEmail ??
                                              //     userData.email);
                                              await (await FirebaseAuth.instance
                                                      .currentUser())
                                                  .updateEmail(_currentEmail ??
                                                      userData.email);
                                              Navigator.of(context).pop(true);
                                              //CHANGE IT SO SETTINGS FORM CLOSES AND SHOWS APP DRAWER?
                                            }
                                          },
                                        ),
                                        FlatButton(
                                          child: Text('No'),
                                          onPressed: () {
                                            Navigator.of(context).pop(false);
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            }

                            _showMyDialog(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Loading();
          }
        },
      ),
    );
  }

  void _showBottomSheetForSelectingMediaSource(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return GestureDetector(
            child: Container(
              height: 220,
              child: Column(
                children: <Widget>[
                  Divider(
                    height: 1,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 4, top: 4),
                    width: double.infinity,
                    child: FlatButton(
                        child: Text('Camera'),
                        onPressed: () {
                          _onMediaSourcePressed(context, ImageSource.camera);
                        }),
                  ),
                  Divider(
                    height: 1,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 4, top: 4),
                    width: double.infinity,
                    child: FlatButton(
                        child: Text('Gallery'),
                        onPressed: () {
                          _onMediaSourcePressed(context, ImageSource.gallery);
                        }),
                  ),
                ],
              ),
            ),
          );
        });
  }

  Future<void> _onMediaSourcePressed(
      BuildContext context, ImageSource imageSource) async {
    Navigator.pop(context);
    File imageFile = await ImagePicker.pickImage(
      source: imageSource,
    );
    if (imageFile == null) {
      print('no file selected');
      return;
    }
    final imageBytes = await imageFile.readAsBytes();
    final decoder = CoreImage.findDecoderForData(imageBytes);
    if (decoder is CoreImage.GifDecoder) {
      //do not sample the image.
      if (extension(imageFile.path) != ".gif") {
        final startIndex =
            imageFile.path.lastIndexOf(extension(imageFile.path));
        imageFile = await imageFile
            .copy(imageFile.path.replaceRange(startIndex, null, ".gif"));
      }
    } else if (decoder != null) {
      CoreImage.Image image = CoreImage.decodeImage(imageBytes);

      if (image.width > 600 || image.height > 960) {
        double ratio = image.width / image.height;
        CoreImage.Image scaledImage;
        if (ratio > 1.0) {
          scaledImage = CoreImage.copyResize(image, width: 960);
        } else {
          scaledImage = CoreImage.copyResize(image, height: 600);
        }
        final cacheFilename = basename(imageFile.path);
        final fileExtension = extension(imageFile.path);
        final cacheFolder = await getTemporaryDirectory();
        final cacheFile = File(
            '${cacheFolder.path}/${imageFile.path.hashCode}_$cacheFilename');
        await cacheFile.writeAsBytes(
            CoreImage.encodeNamedImage(scaledImage, fileExtension),
            mode: FileMode.write,
            flush: true);
        imageFile = cacheFile;
      }
    } else {
      print('file type not supported');
      return;
    }
    if (imageFile != null) {
      print(imageFile.path);
      setState(() {
        _pickedFile = imageFile;
      });
    } else {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('No image selected'),
        ),
      );
    }
  }
}
