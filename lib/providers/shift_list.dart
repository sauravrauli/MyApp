// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myhealthapp/helpers/database.dart';
import 'package:myhealthapp/models/shifts.dart';
import 'package:myhealthapp/providers/shift_tile.dart';
import 'package:myhealthapp/screens/shift_details_screen.dart';

class ShiftList extends StatefulWidget {
  final String uid;
  final List<Shift> myShifts;
  ShiftList({this.uid, this.myShifts});
  @override
  _ShiftListState createState() => _ShiftListState();
}

class _ShiftListState extends State<ShiftList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.myShifts.length,
      itemBuilder: (context, index) {
        final shift = widget.myShifts[index];
        if (shift.uid != widget.uid) {
          return InkWell(
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ShiftDetailsScreen(shiftDetails: widget.myShifts[index]),
                ),
              );
            },
            child: Dismissible(
              direction: DismissDirection.endToStart,
              confirmDismiss: (direction) async {
                return showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    title: Text('Are you sure?'),
                    content: Text(
                      'Are you sure you want to delete this shift?',
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text('NO'),
                        onPressed: () {
                          Navigator.of(ctx).pop(false);
                        },
                      ),
                      FlatButton(
                        child: Text('YES'),
                        onPressed: () async {
                          Scaffold.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Your shift has been deleted."),
                            ),
                          );
                          await DBService().deleteShift(shift);
                          Navigator.of(ctx).pop(true);
                        },
                      )
                    ],
                  ),
                );
              },
              background: Container(
                color: Colors.red,
                child: Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 40,
                ),
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 25),
                margin: EdgeInsets.fromLTRB(20, 13, 20, 0),
              ),
              key: ValueKey(shift.shiftId),
              child: ShiftTile(
                shiftInfo: widget.myShifts[index],
              ),
            ),
          );
        } else {
          return ShiftTile(
            shiftInfo: widget.myShifts[index],
            key: ValueKey(shift.shiftId),
          );
        }
      },
    );
  }
}
