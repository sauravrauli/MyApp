import 'package:flutter/material.dart';

class ViewShiftsScreen extends StatelessWidget {
  static const routeName = '/view-shifts';
  const ViewShiftsScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Available Shifts'),
      ),
      body: Center(
        child: Text('UPCOMING SHIFTS HERE ...'),
      ),
    );
  }
}
