import 'package:flutter/material.dart';
import 'package:myhealthapp/screens/authenticate/authenticate.dart';
import 'package:myhealthapp/screens/tabs_screen.dart';
import 'package:provider/provider.dart';
import '../models/user.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);

    //return either home or authenticate widget
    if (user == null) {
      return Authenticate();
    } else {
      return TabsScreen(uid: user.uid);
    }
  }
}
