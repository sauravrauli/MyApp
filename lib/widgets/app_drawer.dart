import 'package:flutter/material.dart';
import 'package:myhealthapp/helpers/database.dart';
import 'package:myhealthapp/models/user.dart';
import 'package:myhealthapp/shared/loading.dart';
import 'package:myhealthapp/shared/utility.dart';
import 'package:myhealthapp/widgets/settings_form.dart';
//import 'package:path/path.dart';
import 'package:provider/provider.dart';

import 'package:myhealthapp/providers/auth2.dart';
//import 'package:myhealthapp/screens/auth_screen.dart';
//import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    return Drawer(
      child: StreamBuilder<User>(
          stream: DBService(uid: user.uid).usersData,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              User userData = snapshot.data;

              return Column(children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  color: Colors.blue,
                  child: FutureBuilder(
                      future: getPhotoUrl(userData.image),
                      builder: (ctx, snapshot) {
                        if (snapshot.hasData) {
                          return ListTile(
                            contentPadding: EdgeInsets.all(16),

                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(snapshot.data),
                            ),
                            title: Text(
                              '${userData.firstName}'
                              " "
                              '${userData.lastName}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            subtitle: Text(
                              'Email: ${userData.email}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            // automaticallyImplyLeading: false,
                          );
                        } else {
                          return Loading();
                        }
                      }),
                  height: 125,
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.exit_to_app),
                  title: Text(
                    'Log-Out',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () async {
                    Navigator.of(context).pop();
                    await _auth.signOut();
                    // Provider.of<Auth>(context, listen: false).logout();
                  },
                ),
                ListTile(
                  leading: Icon(Icons.settings),
                  title: Text(
                    'Settings',
                    style: TextStyle(fontSize: 18),
                  ),
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SettingsForm(),
                      ),
                    );

                    // code goes here ... for seeing users settings and changing them e.g. details.
                  },
                )
              ]);
            } else {
              return Loading();
            }
          }),
    );
  }
}
