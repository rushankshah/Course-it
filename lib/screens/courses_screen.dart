import 'dart:convert';

import 'package:courseit/models/course.dart';
import 'package:courseit/screens/single_course_screen.dart';
import 'package:courseit/utils/constants.dart';
import 'package:courseit/utils/db_connections.dart';
import 'package:flutter/material.dart';

class CoursesScreen extends StatefulWidget {
  @override
  _CoursesScreenState createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  List<Course> courses;
  List<Course> suggestionsList = List<Course>();
  String query = '';
  TextEditingController searchController = TextEditingController();

  Future<List> getCourses() async {
    var response = await DBConnections().getAllCourses();
    var courses = jsonDecode(response);
    List<dynamic> dynamicList = courses['courses'];
    List<Course> courseList = List<Course>();
    dynamicList.forEach((element) {
      print(element['Name']);
      courseList.add(Course(
          publishedDate: element["Published_Date"],
          courseid: element['_id'],
          name: element['Name'],
          description: element['description'],
          publisher: element['Publisher'],
          thumbnail: element['Thumbnail'],
          price: 200));
    });
    return courseList;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCourses(),
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.none){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        courses = snapshot.data;
        return ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: TextField(
                controller: searchController,
                onChanged: (val) {
                  setState(() {
                    suggestionsList = val.isEmpty
                        ? []
                        : courses
                            .where((Course element) => element.name
                                .toLowerCase()
                                .contains(val.toLowerCase()))
                            .toList();
                    print(suggestionsList);
                    query = val;
                  });
                },
                style: kTextField,
                decoration: InputDecoration(
                  hintText: 'Search for a course',
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Colors.teal,
                    ),
                    onPressed: () {
                      WidgetsBinding.instance.addPostFrameCallback(
                          (_) => searchController.clear());
                      setState(() {
                        query = '';
                      });
                    },
                  ),
                ),
              ),
            ),
            query.isEmpty
                ? ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
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
                              leading: Image.network(courses[index].thumbnail),
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
                    })
                : ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: suggestionsList.length,
                    itemBuilder: (context, index) {
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
                              leading: Image.network(courses[index].thumbnail),
                              title: Text(
                                'Title: ' + suggestionsList[index].name,
                              ),
                              subtitle: Text(
                                'Subtitle: ' +
                                    suggestionsList[index].description,
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
          ],
        );
      },
    );
  }
}
