import 'package:flutter/material.dart';
import 'package:myhealthapp/providers/team_list.dart';
import 'package:provider/provider.dart';
import '../helpers/database.dart';
import '../models/user.dart';

class ViewTeamScreen extends StatelessWidget {
  static const routeName = '/view-team';
  const ViewTeamScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<User>>.value(
      value: DBService().getAllUsers,
      child: Scaffold(
        body: TeamList()
      ),
    );
  }
}
