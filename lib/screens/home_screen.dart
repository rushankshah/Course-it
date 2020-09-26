import 'package:courseit/screens/courses_screen.dart';
import 'package:courseit/screens/dashboard_screen.dart';
import 'package:courseit/screens/my_courses_screen.dart';
import 'package:courseit/utils/constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Course it',
          style: kHeaderStyle,
        ),
      ),
      body: _currentIndex == 0 ? CoursesScreen() : _currentIndex == 1 ? MyCoursesScreeen() : Dashboard(),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index){
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
              ),
              title: Text(
                'Courses',
                style: kNormalTextStyle,
              )
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.add_shopping_cart,
              ),
              title: Text(
                'My Courses',
                style: kNormalTextStyle,
              )
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.account_box,
              ),
              title: Text(
                'My Dashboard',
                style: kNormalTextStyle,
              )
            ),
          ],
        ),
      ),
    );
  }
}
