import 'package:flutter/material.dart';
import 'package:myhealthapp/helpers/database.dart';
import 'package:myhealthapp/models/user.dart';
import 'package:myhealthapp/screens/confirm_shift_screen.dart';
import 'package:myhealthapp/screens/view_shifts_screen.dart';
import 'package:myhealthapp/screens/view_timesheet_screen.dart';
import 'package:myhealthapp/shared/loading.dart';
import 'package:provider/provider.dart';
//import '../models/shifts.dart';

class ViewOverviewScreen extends StatelessWidget {
  static const routeName = '/view-overview';
  const ViewOverviewScreen({Key key}) : super(key: key);
  void clickButton() {
    print('Answer chosen!');
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      body: StreamBuilder<User>(
        stream: DBService(uid: user.uid).usersData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            User userData = snapshot.data;

            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: Card(
                      child: Container(
                        color: Colors.blue[200],
                        width: double.infinity,
                        height: 100,
                        child: Row(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(10),
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.brown.shade800,
                                child:
                                    Text('SR', style: TextStyle(fontSize: 30)),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                leading: Text(
                                    '${userData.firstName}'
                                    " "
                                    '${userData.lastName}',
                                    style: TextStyle(
                                        fontSize: 30,
                                        fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.left),
                                trailing: Text(userData.email),
                              ),
                            ),
                          ],
                        ),
                      ),
                      elevation: 5,
                    ),
                  ),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          color: Colors.red[300],
                          child: Text(
                            'START AN UNSCHEDULED SHIFT NOW',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () {
                            print('You tapped on RaisedButton');
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Text(
                        'Shifts',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                  ),
                  Container(
                    child: RaisedButton(
                      elevation: 5,
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          'Available Shifts',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<Null>(
                            builder: (BuildContext context) {
                              return new ViewShiftsScreen();
                            },
                          ),
                        );
                      },
                      color: Colors.blue,
                    ),
                  ),
                  Container(
                    child: RaisedButton(
                      child: Container(
                        width: double.infinity,
                        child: Text(
                          'Confirm Shift',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<Null>(
                            builder: (BuildContext context) {
                              return new ConfirmShiftScreen();
                            },
                          ),
                        );
                      },
                      color: Colors.blue,
                    ),
                  ),
                  Container(
                    child: RaisedButton(
                      child: Container(
                          width: double.infinity,
                          child: Text('Timesheet',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15))),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute<Null>(
                            builder: (BuildContext context) {
                              return new ViewTimesheetScreen();
                            },
                          ),
                        );
                      },
                      color: Colors.blue,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Text(
                        'Time Management',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                  ),
                  Flexible(
                      child: Column(
                    children: <Widget>[
                      Flexible(
                        child: ButtonTheme(
                          minWidth: double.infinity,
                          child: RaisedButton.icon(
                            icon: Icon(Icons.directions_walk),
                            onPressed: () {},
                            label: Container(
                              child: Text(
                                'My Leave',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 15),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: ButtonTheme(
                          minWidth: double.infinity,
                          child: RaisedButton.icon(
                            icon: Icon(Icons.calendar_today),
                            onPressed: () {},
                            label: Text(
                              'My Dates',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Flexible(
                        child: ButtonTheme(
                          minWidth: double.infinity,
                          child: RaisedButton.icon(
                            icon: Icon(Icons.close),
                            onPressed: () {},
                            label: Text(
                              'My Unavailability',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ))
                ]);
          } else {
            return Loading();
          }
        },
      ),
    );
  }
}
