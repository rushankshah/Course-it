import 'package:courseit/models/course.dart';
import 'package:courseit/screens/single_course_screen.dart';
import 'package:courseit/utils/constants.dart';
import 'package:flutter/material.dart';

class CoursesScreen extends StatefulWidget {
  @override
  _CoursesScreenState createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  List<Course> courses = List<Course>();
  List<Course> suggestionsList = List<Course>();
  String query = '';
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
      setState(() {
        courses.add(Course(
            name: 'Rushank',
            description: 'LD',
            thumbnail: 'https://www.gstatic.com/webp/gallery3/1.png',
            publisher: 'PE',
            price: 100,
            publishedDate: 'D',
            courseid: 'test_id'
            ));
        courses.add(Course(
            name: 'Soham',
            description: 'LD',
            thumbnail: 'https://www.gstatic.com/webp/gallery3/1.png',
            publisher: 'PE',
            price: 200,
            publishedDate: 'D',
            courseid: 'test_id'
            ));
      });
  }
  @override
  Widget build(BuildContext context) {
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
                        .where((Course element) => element.name.toLowerCase().contains(val.toLowerCase()))
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
                    WidgetsBinding.instance
                        .addPostFrameCallback((_) => searchController.clear());
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
                            Navigator.push(context, MaterialPageRoute(builder: (context) => SingleCourseScreen(course: courses[index],)));
                          },
                          splashColor: Colors.teal.withAlpha(30),
                          child: ListTile(
                            leading: Image.network(courses[index].thumbnail),
                            title: Text(
                              'Title: ' + courses[index].name,
                            ),
                            subtitle: Text(
                              'Subtitle: ' +
                                  courses[index].description,
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
                        print('Tapped');
                      },
                      splashColor: Colors.teal.withAlpha(30),
                      child: ListTile(
                        leading: Image.network(courses[index].thumbnail),
                        title: Text(
                          'Title: ' + suggestionsList[index].name,
                        ),
                        subtitle: Text(
                          'Subtitle: ' + suggestionsList[index].description,
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ],
    );
  }
}