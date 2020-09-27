import 'dart:convert';

import 'package:courseit/models/course.dart';
import 'package:courseit/screens/check_screen.dart';
import 'package:courseit/screens/single_course_screen.dart';
import 'package:courseit/utils/constants.dart';
import 'package:courseit/utils/db_connections.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              onPressed: () async{
                var pref = await SharedPreferences.getInstance();
                print(pref.setString(kStatusText, kLogOutText));
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => CheckScreen()));
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
        ),
        FutureBuilder(
          future: getMyCourses(),
          builder: (context, snapshot){
            if(snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.none)
            {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            print(snapshot.error);
            List<Course> courses = snapshot.data;
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: courses.length,
              itemBuilder: (context, index){
                return Padding(
                        padding: EdgeInsets.all(10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SingleCourseScreen(
                                            course: courses[index],
                                          )));
                            },
                            splashColor: Colors.teal.withAlpha(30),
                            child: ListTile(
                              leading: Image.network(courses[index].thumbnail != null?courses[index].thumbnail : 'https://upload.wikimedia.org/wikipedia/commons/thumb/b/b6/Image_created_with_a_mobile_phone.png/330px-Image_created_with_a_mobile_phone.png'),
                              title: Text(
                                'Title: ' + courses[index].name,
                              ),
                              subtitle: Text(
                                'Subtitle: ' + courses[index].description,
                              ),
                            ),
                          ),
                        ),
                      );
            });
          },
        )
      ],
    );
  }
  Future<List<Course>> getMyCourses()async{
                var pref = await SharedPreferences.getInstance();
                var token = pref.getString(kStatusText);
    var resp = await DBConnections().getUserCourses(
                    token:
                        token);
                resp = jsonDecode(resp);
                if (resp['success'] == true) {
                  print('reached here');
                  List<dynamic> dynamicList = resp['data'];
                  List<Course> courseList = List<Course>();
                  dynamicList.forEach((element) {
                    print('reached here 2');
                    courseList.add(Course(
                        publishedDate: element['Course']["Published_Date"],
                        courseid: element['Course']['_id'],
                        name: element['Course']['Name'],
                        description: element['Course']['description'],
                        publisher: element['Course']['Publisher'],
                        thumbnail: element['Course']['Thumbnail'],
                        price: 200));
                  });
                  return courseList;
                }
                else{
                  return null;
                }
  }
}
