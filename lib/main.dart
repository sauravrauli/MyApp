import 'package:flutter/material.dart';
import 'package:myhealthapp/screens/add_comment_screen.dart';
import 'package:myhealthapp/screens/add_shift_screen.dart';
//import 'package:myhealthapp/screens/authenticate/sign_in.dart';
import 'package:myhealthapp/screens/shift_details_screen.dart';
// import 'package:myhealthapp/screens/authenticate/authenticate.dart';
// import 'package:myhealthapp/screens/tabs_screen.dart';
// import 'package:myhealthapp/screens/team_detail_screen.dart';
import 'package:myhealthapp/screens/view_overview_screen.dart';
import 'package:myhealthapp/screens/view_schedule.dart';
//import 'package:myhealthapp/screens/view_team_screen.dart';
import 'package:myhealthapp/screens/wrapper.dart';
import './screens/view_overview_screen.dart';
//import './screens/tabs_screen.dart';
//import './screens/confirm_shift_screen.dart';
import './screens/view_news_screen.dart';
//import './screens/view_shifts_screen.dart';
//import './screens/view_timesheet_screen.dart';
// import './screens/auth_screen.dart';
// import './screens/authenticate/authenticate.dart';
//import './screens/add_comment_screen.dart';
// import './screens/comment_detail_screen.dart';

import 'package:provider/provider.dart';
// import './providers/auth.dart';
// import './providers/user_comments.dart';
// import './providers/comments.dart';
import './providers/auth2.dart';
import './models/user.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        StreamProvider<User>.value(
          value: AuthService().user,
        ),
        //  ChangeNotifierProvider.value(
        //  value: UserComments(),
        // ),
        //ChangeNotifierProvider.value(
        //value: Comments(),
        // ),
      ],
      child: Consumer<User>(
          builder: (ctx, auth, _) => MaterialApp(
                title: 'NHS Register',
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                  accentColor: Colors.blue,
                ),
                home: //auth.isAuth
                    //? TabsScreen()
                    // :
                    Wrapper(), //change first page output on emulator.
                onGenerateRoute: (settings) {
                  return MaterialPageRoute(builder: (_) {
                    switch (settings.name) {
                      case ViewNewsScreen.routeName:
                        return ViewNewsScreen();
                        break;

                      case ViewScheduleScreen.routeName:
                        return ViewScheduleScreen(uid: settings.arguments);
                        break;
                      case ViewOverviewScreen.routeName:
                        return ViewOverviewScreen();
                        break;
                      case AddCommentScreen.routeName:
                        return AddCommentScreen();
                        break; //added this
                      case AddShiftScreen.routeName:
                        return AddShiftScreen();
                        break;
                      case ShiftDetailsScreen.routeName:
                        return ShiftDetailsScreen();
                        break;
                    }
                  });
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
