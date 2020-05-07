import 'package:flutter/material.dart';

class VisualOverview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          height: size.height * .45,
          decoration: BoxDecoration(
            color: Colors.lightBlue[300],
          ),
        ),
        Text(
          'Good Morning \nSaurav',
          style: Theme.of(context)
              .textTheme
              .display1
              .copyWith(fontWeight: FontWeight.w900),
        )
      ],
    ));
  }
}
