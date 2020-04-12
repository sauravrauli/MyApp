import 'package:flutter/material.dart';

class ConfirmShiftScreen extends StatelessWidget {
  const ConfirmShiftScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Confirm A Shift '),
      ),
      body: Center(
        child: Text('CONFIRM SHIFT:'),
      ),
    );
  }
}
