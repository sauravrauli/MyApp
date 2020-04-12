import 'package:flutter/material.dart';
import 'package:myhealthapp/screens/confirm_shift_screen.dart';
import 'package:myhealthapp/screens/view_shifts_screen.dart';
import 'package:myhealthapp/screens/view_timesheet_screen.dart';
//import '../models/shifts.dart';

class ViewOverviewScreen extends StatelessWidget {
  static const routeName = '/view-overview';
  const ViewOverviewScreen({Key key}) : super(key: key);
  void clickButton() {
    print('Answer chosen!');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Shifts',
                style: TextStyle(fontSize: 25)),
            RaisedButton(
              elevation: 5,
              child: Container(
                  width: double.infinity,
                  child:
                      Text('Available Shifts', style: TextStyle(fontSize: 15))),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute<Null>(builder: (BuildContext context) {
                  return new ViewShiftsScreen();
                }));
              },
              color: Colors.blue,
            ),
            RaisedButton(
              child: Container(
                  width: double.infinity,
                  child: Text('Confirm Shift', style: TextStyle(fontSize: 15))),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute<Null>(builder: (BuildContext context) {
                  return new ConfirmShiftScreen();
                }));
              },
              color: Colors.blue,
            ),
            RaisedButton(
              child: Container(
                  width: double.infinity,
                  child: Text('Timesheet', style: TextStyle(fontSize: 15))),
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute<Null>(builder: (BuildContext context) {
                  return new ViewTimesheetScreen();
                }));
              },
              color: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
