import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
  hintText: 'Email',
  fillColor: Colors.white,
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.blue, width: 2.0),
  ),
);

Color darkGreyColor = new Color(0xFF212128);
TextStyle welcomeUserStyle = new TextStyle(
  fontSize: 30,
  fontWeight: FontWeight.bold,
  fontFamily: 'Avenir',
  color: Colors.white,
);

TextStyle commentHeader = new TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.white,
);
TextStyle commentTrailing = new TextStyle(
  fontSize: 15,
  color: Colors.white,
);

TextStyle userHeaders = new TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  fontFamily: 'Avenir',
  color: Colors.black,
);

TextStyle contactDetailHeaders = new TextStyle(
  fontSize: 19,
  color: Colors.grey[800],
);
