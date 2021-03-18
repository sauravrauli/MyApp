import 'package:flutter/material.dart';
import 'package:myhealthapp/models/shifts.dart';
// import 'package:myhealthapp/screens/shift_details_screen.dart';
// import 'package:myhealthapp/screens/view_schedule.dart';

class ShiftTile extends StatelessWidget {
  final Shift shiftInfo;
  ShiftTile({this.shiftInfo, ValueKey<String> key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 1, 10, 0),
        decoration: new BoxDecoration(
          color: Colors.lightBlue[100],
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(40),
            bottomLeft: const Radius.circular(40),
            bottomRight: const Radius.circular(20),
          ),
          gradient: new LinearGradient(
            colors: [Colors.blue[600], Colors.blue, Colors.white],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
        ),

        // child: ListTile(
        //   leading: CircleAvatar(
        //       radius: 30.0,
        //       backgroundImage: NetworkImage(
        //           'https://img.icons8.com/pastel-glyph/2x/person-male.png')),
        //   title: Text(
        //     '${shiftInfo.firstName}'
        //     " "
        //     '${shiftInfo.lastName}', //how do i make the first letter of name always CAPS?
        //     style: TextStyle(fontSize: 15, letterSpacing: 1.0),
        //   ),
        //   trailing: Text(info),
        //   subtitle: Text("${shiftInfo.area}" ?? ""),
        // ),
        height: 100,
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            new Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Padding(
                    padding: new EdgeInsets.only(left: 10.0, right: 10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: new BorderRadius.all(
                          new Radius.circular(50),
                        ),
                        border:
                            new Border.all(color: Colors.blueAccent, width: 2),
                      ),
                      child: new CircleAvatar(
                        radius: 35.0,
                        backgroundColor: Colors.transparent,
                        child: Icon(
                          Icons.work,
                          size: 35,
                          color: Colors.blue[600],
                        ),
                      ),
                    ),
                  ),
                  new Expanded(
                    child: new Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          new Text(
                            '${shiftInfo.firstName}'
                            " "
                            '${shiftInfo.lastName}',
                            style: new TextStyle(
                                fontSize: 20.0,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          new SizedBox(height: 8.0),
                          new Row(children: <Widget>[
                            new Column(
                              children: <Widget>[
                                SizedBox(width: 75),
                                new Text('Location:',
                                    style: new TextStyle(
                                        fontSize: 12.0, color: Colors.white)),
                                new Text('${shiftInfo.area}',
                                    style: new TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            new Column(
                              children: <Widget>[
                                new Text('Date:',
                                    style: new TextStyle(
                                        fontSize: 12.0, color: Colors.white)),
                                new SizedBox(width: 100), //width between dates.
                                new Text('${shiftInfo.date}',
                                    style: new TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                            new Column(
                              children: <Widget>[
                                new SizedBox(width: 65),
                                new Text('Time:',
                                    style: new TextStyle(
                                        fontSize: 12.0, color: Colors.white)),
                                new Text('${shiftInfo.time}',
                                    style: new TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ],
                            )
                          ]),
                        ]),
                  ),
                ]),
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Banner(
                  message: shiftInfo.isApproved == ShiftStatus.approved
                      ? 'Approved'
                      : 'Pending',
                  textStyle: TextStyle(color: Colors.black),
                  location: BannerLocation.topEnd,
                  color: shiftInfo.isApproved == ShiftStatus.approved
                      ? Colors.green.withOpacity(0.8)
                      : Colors.yellowAccent.withOpacity(0.8),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  String get info {
    String time = shiftInfo.time ?? "";
    String date = shiftInfo.date ?? "";
    return time + ", " + date;
  }
}
