import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon) {
    return ListTile(
      leading: Icon(
        icon,
        size: 27,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'Schyler-Regular',
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: () {
        //....
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).primaryColor,
            child: Text(
              'NHS Register',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 30,
                  color: Theme.of(context).accentColor),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          buildListTile(
            'Settings',
            Icons.settings,
          ),
          buildListTile(
            'Log-Out',
            Icons.exit_to_app,
          ),
        ],
      ),
    );
  }
}
