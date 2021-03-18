import 'package:flutter/material.dart';
import 'package:myhealthapp/models/user.dart';
import 'package:myhealthapp/shared/loading.dart';
import 'package:myhealthapp/shared/utility.dart';
import '../screens/team_detail_screen.dart';

import 'package:url_launcher/url_launcher.dart';

class TeamTile extends StatefulWidget {
  final User usersInfo;
  TeamTile({this.usersInfo});

  @override
  _TeamTileState createState() => _TeamTileState();
}

class _TeamTileState extends State<TeamTile> {
  void _launchCaller(String number) async {
    var url = "tel:${widget.usersInfo.phoneNo.toString()}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not place call.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Container(
        height: 100,
        child: Card(
          margin: EdgeInsets.fromLTRB(10, 6, 10, 0),
          child: FutureBuilder(
            future: getPhotoUrl(widget.usersInfo.image),
            builder: (ctx, snapshot) {
              if (snapshot.hasData) {
                return ListTile(
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(snapshot.data),
                  ),
                  title: Text(
                    '${widget.usersInfo.firstName}'
                    " "
                    '${widget.usersInfo.lastName}', //how do i make the first letter of name always CAPS?
                    style: TextStyle(fontSize: 20, letterSpacing: 1.0),
                  ),
                  subtitle: Text(widget.usersInfo.email),
                  trailing: RaisedButton.icon(
                    onPressed: () {
                      if (widget.usersInfo.phoneNo != null)
                        return _launchCaller('${widget.usersInfo.phoneNo}');
                      else {
                        return null;
                      }
                    },
                    icon: Icon(Icons.call),
                    label: Text(
                      'Call',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),

                  //trailing: Text(usersInfo.phoneNo ?? '+44'),
                  onTap: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            TeamDetailScreen(myDetails: widget.usersInfo),
                      ),
                    );
                  },
                );
              } else {
                return Loading();
              }
            },
          ),
        ),
      ),
    );
  }
}
