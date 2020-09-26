import 'package:courseit/utils/constants.dart';
import 'package:courseit/utils/db_connections.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FlatButton(
              child: Text(
                'Log out?',
                style: kNormalTextStyle,
                textAlign: TextAlign.end,
              ),
              onPressed: ()async{
                await DBConnections().getUserCourses(userId: '5f6e432663adfe308c7e9fc2');
              },
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: Text(
            'Your courses: ',
            style: kTitleStyle,
          ),
        )
      ],
    );
  }
}
