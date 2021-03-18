import 'package:flutter/material.dart';
import 'package:myhealthapp/providers/team_list.dart';
import 'package:myhealthapp/shared/loading.dart';
// import 'package:provider/provider.dart';
import '../helpers/database.dart';
import '../models/user.dart';

class ViewTeamScreen extends StatelessWidget {
  static const routeName = '/view-team';
  const ViewTeamScreen({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<User>>(
        stream: DBService().getAllUsers,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<User> userData = snapshot.data;
            return Scaffold(body: TeamList(myData: userData));
          } else {
            return Loading();
          }
        });
  }
}
