import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:myhealthapp/helpers/database.dart';
import 'package:myhealthapp/models/shifts.dart';
import 'package:myhealthapp/models/user.dart';
import 'package:myhealthapp/shared/constants.dart';
import 'package:myhealthapp/shared/loading.dart';
import 'package:provider/provider.dart';

class ShiftDetailsScreen extends StatelessWidget {
  final Shift shiftDetails;
  final String uid;
  ShiftDetailsScreen({this.shiftDetails, this.uid});

  static const routeName = '/shift-details';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Contact Info'),
      ),
      body: StreamBuilder<List<Shift>>(
        stream: DBService().shifts,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                ListTile(
                  leading: Icon(Icons.person),
                  title: Text(
                    'Name: ${shiftDetails.firstName}'
                    " "
                    '${shiftDetails.lastName}',
                    style: contactDetailHeaders,
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.card_travel),
                  title: Text(
                    'Area: ${shiftDetails.area}',
                    style: contactDetailHeaders,
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.date_range),
                  title: Text(
                    'Date: ${shiftDetails.date}',
                    style: contactDetailHeaders,
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.schedule),
                  title: Text(
                    'Time: ${shiftDetails.time}',
                    style: contactDetailHeaders,
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.local_dining),
                  title: Text(
                    'Break Time: ${shiftDetails.break_}',
                    style: contactDetailHeaders,
                  ),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.note_add),
                  title: Text(
                    'Shift Notes: ${shiftDetails.notes}',
                    style: contactDetailHeaders,
                  ),
                ),
                Divider(),
              ],
            );
          } else {
            return Loading();
          }
          
        },
        
      ),
    );
  }
}
