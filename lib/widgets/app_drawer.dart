import 'package:flutter/material.dart';
import 'package:myhealthapp/widgets/settings_form.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import 'package:myhealthapp/providers/auth2.dart';
import 'package:myhealthapp/screens/auth_screen.dart';
//import '../providers/auth.dart';

class AppDrawer extends StatelessWidget {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text('Hello User!'),
            automaticallyImplyLeading: false,
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
        ],
      ),
    );
  }
}
