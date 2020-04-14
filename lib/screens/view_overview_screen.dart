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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            child: Card(
              child: Container(
                color: Colors.blue[200],
                width: double.infinity,
                height: 150,
                child: Row(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(10),
                      child: CircleAvatar(
                        radius: 30,
                        backgroundColor: Colors.brown.shade800,
                        child: Text('SR', style: TextStyle(fontSize: 30)),
                      ),
                    ),
                    Expanded(
                      child: Text('Saurav Rauli',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.left),
                    ),
                  ],
                ),
              ),
              elevation: 5,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              RaisedButton(
                child: Text('I am RaisedButton'),
                onPressed: () {
                  print('You tapped on RaisedButton');
                },
              ),
              RaisedButton(
                child: Text('I am RaisedButton'),
                onPressed: () {
                  print('You tapped on RaisedButton');
                },
              ),
            ],
          ),
          SizedBox(
            height: 25,
          ),
          Text(
            'Shifts',
            style: TextStyle(fontSize: 25),
          ),
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
    );
  }
}
