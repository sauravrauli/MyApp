import 'package:flutter/material.dart';
import 'package:myhealthapp/helpers/database.dart';
import 'package:myhealthapp/models/user.dart';
import 'package:myhealthapp/shared/constants.dart';
import 'package:myhealthapp/shared/loading.dart';
import 'package:provider/provider.dart';

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
                      SizedBox(height: 50),
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
                      //drop?
                      //slider?
                      SizedBox(height: 20),
                      Center(
                        child: RaisedButton(
                          color: Colors.blue,
                          child: Text(
                            'Update',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              await DBService(uid: user.uid).updateUserData(
                                //need a new function here, as this updates all fields and i am not changing password/DOB here.
                                _currentFirstName ?? userData.firstName,
                                _currentLastName ?? userData.lastName,
                                _currentEmail ?? userData.email,
                                _currentPassword ?? userData.password,
                                _currentDateOfBirth ?? userData.dateOfBirth,
                                null, //TODO: fix this later
                              );
                            }
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
}
