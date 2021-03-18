import 'package:flutter/material.dart';
import 'package:myhealthapp/providers/auth2.dart';
import 'package:myhealthapp/shared/constants.dart';
import 'package:myhealthapp/shared/loading.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String firstName = '';
  String lastName = '';
  String email = '';
  String password = '';
  String phoneNo = '';
  String dateOfBirth = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
                backgroundColor: Colors.blue,
                elevation: 0.0,
                title: Text('Sign up to MyNHS')),
            body: Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 20),
                      TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        decoration: textInputDecoration.copyWith(
                            hintText: 'First Name'),
                        validator: (val) => val.isEmpty ? 'Enter a name' : null,
                        onChanged: (val) {
                          setState(() => firstName = val);
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Last Name'),
                        validator: (val) =>
                            val.isEmpty ? 'Enter a last name' : null,
                        onChanged: (val) {
                          setState(() => lastName = val);
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Email'),
                        validator: (val) =>
                            val.isEmpty ? 'Enter an email' : null,
                        onChanged: (val) {
                          setState(() => email = val);
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Password'),
                        validator: (val) => val.length < 6
                            ? 'Enter a password with 6+ chars long'
                            : null,
                        obscureText: true,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Phone No.'),
                        validator: (val) =>
                            val.isEmpty ? 'Enter a phone no' : null,
                        onChanged: (val) {
                          setState(() => phoneNo = val);
                        },
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        decoration:
                            textInputDecoration.copyWith(hintText: 'Enter DOB'),
                        validator: (val) => val.isEmpty ? 'Enter a DOB' : null,
                        onChanged: (val) {
                          setState(() => dateOfBirth = val);
                        },
                      ),
                      SizedBox(height: 20),
                      RaisedButton(
                        color: Colors.blue[400],
                        child: Text(
                          'SIGNUP',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result =
                                await _auth.registerWithEmailAndPassword(
                              email,
                              password,
                              firstName,
                              lastName,
                              dateOfBirth,
                              phoneNo,
                            );
                            if (result == null) {
                              setState(() {
                                error = "Please supply a valid email";
                                loading = false;
                              });
                            }
                          }
                          print(email);
                          print(password);
                          print(firstName);
                          print(lastName);
                          print(dateOfBirth);
                          print(phoneNo);
                        },
                      ),
                      FlatButton(
                        onPressed: () {
                          widget.toggleView();
                        },
                        child: Text(
                          'LOGIN INSTEAD',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                      SizedBox(height: 12),
                      Text(
                        error,
                        style: TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
