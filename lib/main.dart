import 'package:flutter/material.dart';
import 'package:myhealthapp/screens/add_comment_screen.dart';
import 'package:myhealthapp/screens/tabs_screen.dart';
import 'package:myhealthapp/screens/view_overview_screen.dart';
import 'package:myhealthapp/screens/view_schedule.dart';
import 'package:myhealthapp/screens/view_team_screen.dart';
import './screens/view_overview_screen.dart';
//import './screens/tabs_screen.dart';
//import './screens/confirm_shift_screen.dart';
import './screens/view_news_screen.dart';
//import './screens/view_shifts_screen.dart';
//import './screens/view_timesheet_screen.dart';
import './screens/auth_screen.dart';
//import './screens/add_comment_screen.dart';
import './screens/comment_detail_screen.dart';

import 'package:provider/provider.dart';
import './providers/auth.dart';
import './providers/user_comments.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: UserComments(),
        )
      ],
      child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
                title: 'NHS Register',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  accentColor: Colors.white,
                ),
                home: auth.isAuth
                    ? TabsScreen()
                    : TabsScreen(), //change first page output on emulator.
                routes: {
                  ViewNewsScreen.routeName: (ctx) => ViewNewsScreen(),
                  ViewTeamScreen.routeName: (ctx) => ViewTeamScreen(),
                  ViewScheduleScreen.routeName: (ctx) => ViewScheduleScreen(),
                  ViewOverviewScreen.routeName: (ctx) => ViewOverviewScreen(),
                  AddCommentScreen.routeName: (ctx) => AddCommentScreen(), //added this 
                  CommentDetailScreen.routeName: (ctx) => CommentDetailScreen(),
                },
              )),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('NHSRegister'),
//         ),
//         body: Center(
//           child: Text('Lets build a app!'),
//         ));
//   }
// }
