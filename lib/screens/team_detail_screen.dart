import 'package:flutter/material.dart';
import 'package:myhealthapp/helpers/database.dart';
import 'package:myhealthapp/models/user.dart';
import 'package:myhealthapp/shared/constants.dart';
import 'package:myhealthapp/shared/loading.dart';
import 'package:myhealthapp/shared/utility.dart';
import 'package:provider/provider.dart';

class TeamDetailScreen extends StatelessWidget {
  final User myDetails;
  TeamDetailScreen({this.myDetails});

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Employee Contact Info'),
      ),
      body: StreamBuilder<User>(
        stream: DBService(uid: user.uid).usersData,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            //User userData = snapshot.data;

            return Column(children: <Widget>[
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FutureBuilder(
                    future: getPhotoUrl(myDetails.image),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return CircleAvatar(
                          radius: 75,
                          backgroundImage: NetworkImage(snapshot.data),
                        );
                      } else {
                        return Loading();
                      }
                    },
                  ),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  'Name: ${myDetails.firstName}' " " '${myDetails.lastName}',
                  style: contactDetailHeaders,
                ),
              ),
              Divider(),
              ListTile(
                  leading: Icon(Icons.email),
                  title: Text(
                    'Email: ${myDetails.email}',
                    style: contactDetailHeaders,
                  )),
              Divider(),
              ListTile(
                leading: Icon(Icons.phone),
                title: Text(
                  'Phone No. ${myDetails.phoneNo}',
                  style: contactDetailHeaders,
                ),
              ),
              Divider(),
              ListTile(
                leading: Icon(Icons.person),
                title: Text(
                  'DOB: ${myDetails.dateOfBirth}',
                  style: contactDetailHeaders,
                ),
              ),
              Divider(),

              // Expanded(
              //   child: Container(
              //     margin:
              //         const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
              //     decoration: BoxDecoration(
              //       color: Colors.lightBlue,
              //       borderRadius: BorderRadius.all(
              //         Radius.circular(20),
              //       ),
              //       gradient: new LinearGradient(
              //           begin: Alignment.topCenter,
              //           end: Alignment.bottomCenter,
              //           colors: [Colors.lightBlue, Colors.white]),
              //     ),
              //     child: Padding(
              //       padding: const EdgeInsets.all(20.0),
              //       child: Text(
              //         'Name: ${myDetails.firstName}'
              //         " "
              //         '${myDetails.lastName}\n\n'
              //         'Email: ${myDetails.email}\n\n'
              //         'Phone no. ${myDetails.phoneNo ?? '+44'}\n\n'
              //         'DOB: ${myDetails.dateOfBirth}',
              //         style: TextStyle(
              //           fontSize: (20),
              //         ),
              //       ),
              //     ),
              //   ),
              // ),
            ]);
          } else {
            return Loading();
          }
        },
      ),
    );
  }
}
