// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myhealthapp/helpers/database.dart';
import 'package:myhealthapp/models/shifts.dart';
import 'package:myhealthapp/providers/shift_list.dart';
import 'package:myhealthapp/screens/add_shift_screen.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:myhealthapp/shared/loading.dart';

class ViewScheduleScreen extends StatelessWidget {
  static const routeName = '/view-schedule';
  final String uid;
  const ViewScheduleScreen({Key key, this.uid}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    
    return StreamBuilder<List<Shift>>(
        stream: DBService(uid: uid).userShifts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Shift> shiftData = snapshot.data;
            return Scaffold(
              body: ShiftList(myShifts: shiftData),
              floatingActionButton: FloatingActionButton.extended(
                  icon: Icon(Icons.add),
                  label: Text(
                    'ADD SHIFT',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () async {
                   
                    Navigator.of(context).pushNamed(AddShiftScreen.routeName);
                  },
                  elevation: 5,
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            );
          } else {
            if(snapshot.hasError) {
              print(snapshot.error);
            }
            return Scaffold(
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
              floatingActionButton: FloatingActionButton.extended(
                  icon: Icon(Icons.add),
                  label: Text(
                    'ADD SHIFT',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushNamed(AddShiftScreen.routeName);
                  },
                  elevation: 5,
                ),
                          body: Column(
                children: <Widget>[
                  SizedBox(
                    height: 150,
                  ),
                  Container(
                    height: 200,
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('assets/images/office_work.png'),
                                alignment: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'No shifts scheduled',
                    style: TextStyle(
                      color: Colors.blue[700],
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  Icon(
                    Icons.calendar_today,
                    size: 60,
                    color: Colors.blue[700],
                  ),
                  SizedBox(height: 100),
                  
                ],
              ),
            );
          }
        });
  }
}
