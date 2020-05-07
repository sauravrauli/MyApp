import 'package:flutter/material.dart';
import 'package:myhealthapp/models/user.dart';
import '../screens/team_detail_screen.dart';

class TeamTile extends StatelessWidget {
  final User user;
  TeamTile({this.user});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30.0,
            backgroundColor: Colors.brown,
          ),
          title: Text(
            '${user.firstName}'
            " "
            '${user.lastName}', //how do i make the first letter of name always CAPS?
            style: TextStyle(fontSize: 23, letterSpacing: 1.0),
          ),
          trailing: Text(user.email),
          subtitle: Text('+44 0000 000 000'),
          onTap: () async {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TeamDetailScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
