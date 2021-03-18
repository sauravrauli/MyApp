import 'package:flutter/material.dart';
import 'package:myhealthapp/helpers/database.dart';
import 'package:myhealthapp/models/shifts.dart';
import 'package:myhealthapp/providers/shift_list.dart';
import 'package:myhealthapp/providers/shift_tile.dart';

class ConfirmShiftScreen extends StatelessWidget {
  const ConfirmShiftScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final dbService =  DBService();
    return StreamBuilder<List<MapEntry<String, Shift>>>(
        stream: dbService.pendingShifts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<String> ids = snapshot.data.map((e) => e.key).toList();
            List<Shift> shiftData = snapshot.data.map((e) => e.value).toList();
            return Scaffold(
              appBar: AppBar(title: Text('Confirm Shifts')),
              body: ListView.builder(
                  itemCount: shiftData.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      child: ShiftTile(
                        shiftInfo: shiftData[index],
                      ),
                      onTap: () {
                        showModalBottomSheet(
                          
                          context: context,
                          builder: (ctx) {
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              child: Container(
                                height: 220,
                                child: Column(children: <Widget>[
                                  Divider(
                                    height: 1,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 4, top: 4),
                                    width: double.infinity,
                                    child: FlatButton(
                                      //padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Confirm',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        dbService.updateShift(ids[index], shiftData[index].copyWith(shiftStatus : ShiftStatus.approved));
                                      },
                                    ),
                                  ),
                                   Divider(
                                    height: 1,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 4, top: 4),
                                    width: double.infinity,
                                    child: FlatButton(
                                      //padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Deny',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      onPressed: () async {
                                        Navigator.pop(context);
                                      dbService.updateShift(ids[index], shiftData[index].copyWith(shiftStatus : ShiftStatus.denied));
                                      },
                                    ),
                                  ),

                                   Divider(
                                    height: 1,
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(bottom: 4, top: 4),
                                    width: double.infinity,
                                    child: FlatButton(
                                      //padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      onPressed: () async {
                                        Navigator.pop(context);
                                        dbService.updateShift(ids[index], shiftData[index]);
                                      },
                                    ),
                                  ),
                                ]),
                              ),
                            );
                            
                          },
                          
                        );
                      },
                    );
                  }),
            );
          } else {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            return Scaffold(
              body: Center(
                child: Text('All Shifts Confirmed!'),
              ),
            );
          }
        });
  }
}
