import 'package:flutter/material.dart';
import 'package:myhealthapp/screens/view_schedule.dart';
//import 'package:myhealthapp/widgets/main_drawer.dart';
import '../screens/view_news_screen.dart';
import '../screens/view_team_screen.dart';
import '../screens/view_overview_screen.dart';
//import '../widgets/main_drawer.dart';
import '../widgets/app_drawer.dart';

class TabsScreen extends StatefulWidget {
  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, Object>> _pages = [
    {'page': ViewNewsScreen(), 'title': 'News'},
    {'page': ViewScheduleScreen(), 'title': 'Schedule'},
    {'page': ViewTeamScreen(), 'title': 'My Roster'},
    {'page': ViewOverviewScreen(), 'title': 'My Profile'},
  ];
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_pages[_selectedPageIndex]['title'])
      ),
      drawer: AppDrawer(),
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
          onTap: _selectPage,
          backgroundColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.blue,
          selectedItemColor: Colors.grey,
          currentIndex: _selectedPageIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.chat),
              title: Text('News'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today),
              title: Text('Schedule'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.people),
              title: Text('MyTeam'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('Me'),
            ),
          ]),
    );
  }
}
