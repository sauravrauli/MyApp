import 'package:flutter/material.dart';
import 'package:myhealthapp/providers/team_tile.dart';
// import 'package:provider/provider.dart';
import '../models/user.dart';
// import 'package:myhealthapp/helpers/database.dart';

class TeamList extends StatefulWidget {
  final List<User> myData;
  TeamList({this.myData});

  @override
  _TeamListState createState() => _TeamListState();
}

class _TeamListState extends State<TeamList> {
  @override
  Widget build(BuildContext context) {
    //final users = Provider.of<List<User>>(context) ?? [];
    //print(users);

    return ListView.builder(
      itemCount: widget.myData.length,
      itemBuilder: (context, index) {
        return TeamTile(
          usersInfo: widget.myData[index],
        );
      },
    );
  }
}
