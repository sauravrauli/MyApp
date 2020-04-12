import 'package:flutter/material.dart';

class ViewTimesheetScreen extends StatelessWidget {
  const ViewTimesheetScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Timesheet '),
      ),
      body: Center(
        child: Text(' ... DATES GO IN HERE ...'),
      ),
    );
  }
}
