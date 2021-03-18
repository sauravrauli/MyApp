import 'package:flutter/material.dart';
import 'package:myhealthapp/helpers/database.dart';
import 'package:myhealthapp/models/user.dart';
import 'package:myhealthapp/screens/confirm_shift_screen.dart';
// import 'package:myhealthapp/screens/shift_details_screen.dart';
import 'package:myhealthapp/screens/view_shifts_screen.dart';
import 'package:myhealthapp/screens/view_timesheet_screen.dart';
import 'package:myhealthapp/shared/loading.dart';
import 'package:myhealthapp/shared/utility.dart';
import 'package:provider/provider.dart';
import 'package:myhealthapp/shared/constants.dart';
//import '../models/shifts.dart';

class ViewOverviewScreen extends StatelessWidget {
  static const routeName = '/view-overview';
  const ViewOverviewScreen({Key key}) : super(key: key);

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
                    child: Container(
                      width: double.infinity,
                      height: 160,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(30),
                        ),
                        color: Colors.blue,
                      ),
                      child: Row(
                        children: <Widget>[
                          Container(
                            height: 100,
                            margin: const EdgeInsets.only(left: 30),
                            alignment: Alignment.center,
                            //color: Colors.red,
                            padding: const EdgeInsets.all(10),
                            child: Text(
                                'Welcome,\n${userData.firstName}'
                                " "
                                '${userData.lastName}',
                                style: welcomeUserStyle,
                                textAlign: TextAlign.left),
                          ),
                          Container(
                            margin: const EdgeInsets.only(left: 30),
                            //color: Colors.red,
                            child: FutureBuilder(
                              future: getPhotoUrl(userData.image),
                              builder: (ctx, snapshot) {
                                if (snapshot.hasData) {
                                  return CircleAvatar(
                                    radius: 60,
                                    backgroundImage:
                                        NetworkImage(snapshot.data),
                                  );
                                } else {
                                  return Loading();
                                }
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Container(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: <Widget>[
                  // RaisedButton(
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(18),
                  //   ),
                  //   color: Colors.red[300],
                  //   child: Text(
                  //     'VIEW CONFIRMED SHIFTS',
                  //     style: TextStyle(
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  //   onPressed: () {
                  //     Navigator.of(context).push(
                  //       MaterialPageRoute<Null>(
                  //         builder: (BuildContext context) {
                  //           return new ShiftDetailsScreen();
                  //         },
                  //       ),
                  //     );
                  //     print('You tapped on RaisedButton');
                  //   },
                  // ),
                  //     ],
                  //   ),
                  // ),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: 50,
                      alignment: Alignment.center,
                      child: Text(
                        'Shift Management',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 25,
                            color: Colors.white),
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                            bottomLeft: Radius.circular(50),
                            bottomRight: Radius.circular(50),
                          ),
                          color: Colors.blue),
                    ),
                  ),

                  // Container(
                  //   child: RaisedButton(
                  //     elevation: 5,
                  //     child: Container(
                  //       width: double.infinity,
                  //       child: Text(
                  //         'Available Shifts',
                  //         style: TextStyle(
                  //             fontWeight: FontWeight.bold, fontSize: 15),
                  //       ),
                  //     ),
                  //     onPressed: () {
                  //       Navigator.of(context).push(
                  //         MaterialPageRoute<Null>(
                  //           builder: (BuildContext context) {
                  //             return new ViewShiftsScreen();
                  //           },
                  //         ),
                  //       );
                  //     },
                  //     color: Colors.blue,
                  //   ),
                  // ),
                  // Container(
                  //   child: RaisedButton(
                  //     child: Container(
                  //       width: double.infinity,
                  //       child: Text(
                  //         'Confirm Shift',
                  //         style: TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 15,
                  //         ),
                  //       ),
                  //     ),
                  //     onPressed: () {
                  //       Navigator.of(context).push(
                  //         MaterialPageRoute<Null>(
                  //           builder: (BuildContext context) {
                  //             return new ConfirmShiftScreen();
                  //           },
                  //         ),
                  //       );
                  //     },
                  //     color: Colors.blue,
                  //   ),
                  // ),
                  // Container(
                  //   child: RaisedButton(
                  //     child: Container(
                  //         width: double.infinity,
                  //         child: Text('Timesheet',
                  //             style: TextStyle(
                  //                 fontWeight: FontWeight.bold, fontSize: 15))),
                  //     onPressed: () {
                  //       Navigator.of(context).push(
                  //         MaterialPageRoute<Null>(
                  //           builder: (BuildContext context) {
                  //             return new ViewTimesheetScreen();
                  //           },
                  //         ),
                  //       );
                  //     },
                  //     color: Colors.blue,
                  //   ),
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                            child: CircleAvatar(
                              radius: 65,
                              backgroundImage: AssetImage(
                                  'assets/images/available shifts.png'),
                              backgroundColor: Colors.white,
                            ),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute<Null>(
                                  builder: (BuildContext context) {
                                    return new ViewShiftsScreen();
                                  },
                                ),
                              );
                            }),
                        if (userData.isAdmin)
                          GestureDetector(
                              child: CircleAvatar(
                                radius: 65,
                                backgroundImage: AssetImage(
                                    'assets/images/confirm shifts.png'),
                                backgroundColor: Colors.white,
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute<Null>(
                                    builder: (BuildContext context) {
                                      return new ConfirmShiftScreen();
                                    },
                                  ),
                                );
                              }),
                        GestureDetector(
                          child: CircleAvatar(
                            radius: 65,
                            backgroundImage:
                                AssetImage('assets/images/unavailable.png'),
                            backgroundColor: Colors.white,
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute<Null>(
                                builder: (BuildContext context) {
                                  return new ViewTimesheetScreen();
                                },
                              ),
                            );
                          },
                        ),
                      ]),
                  SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          child: Text(
                            'Available Shifts',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white),
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                              ),
                              color: Colors.blue),
                          height: 30,
                          width: 125,
                        ),
                        if (userData.isAdmin)
                          Container(
                            child: Text(
                              'Confirm Shift',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  color: Colors.white),
                            ),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(50),
                                  topRight: Radius.circular(50),
                                  bottomLeft: Radius.circular(50),
                                  bottomRight: Radius.circular(50),
                                ),
                                color: Colors.blue),
                            height: 30,
                            width: 125,
                          ),
                        Container(
                          child: Text(
                            'Unavailability',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.white),
                          ),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(50),
                                topRight: Radius.circular(50),
                                bottomLeft: Radius.circular(50),
                                bottomRight: Radius.circular(50),
                              ),
                              color: Colors.blue),
                          height: 30,
                          width: 125,
                        ),
                      ])
                ]);

            //   Padding(
            //     padding: const EdgeInsets.all(8.0),
            //     child: Container(
            //       child: Text(
            //         'Time Management',
            //         style: TextStyle(
            //             fontWeight: FontWeight.bold, fontSize: 25),
            //       ),
            //     ),
            //   ),
            //   Flexible(
            //       child: Column(
            //     children: <Widget>[
            //       Flexible(
            //         child: ButtonTheme(
            //           minWidth: double.infinity,
            //           child: RaisedButton.icon(
            //             icon: Icon(Icons.directions_walk),
            //             onPressed: () {},
            //             label: Container(
            //               child: Text(
            //                 'My Leave',
            //                 style: TextStyle(
            //                     fontWeight: FontWeight.bold, fontSize: 15),
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //       Flexible(
            //         child: ButtonTheme(
            //           minWidth: double.infinity,
            //           child: RaisedButton.icon(
            //             icon: Icon(Icons.calendar_today),
            //             onPressed: () {},
            //             label: Text(
            //               'My Dates',
            //               style: TextStyle(
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 15,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //       Flexible(
            //         child: ButtonTheme(
            //           minWidth: double.infinity,
            //           child: RaisedButton.icon(
            //             icon: Icon(Icons.close),
            //             onPressed: () {},
            //             label: Text(
            //               'My Unavailability',
            //               style: TextStyle(
            //                 fontWeight: FontWeight.bold,
            //                 fontSize: 15,
            //               ),
            //             ),
            //           ),
            //         ),
            //       ),
            //     ],
            //   ))

          } else {
            return Loading();
          }
        },
      ),
    );
  }
}
