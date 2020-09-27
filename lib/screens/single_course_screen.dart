import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:courseit/models/course.dart';
import 'package:courseit/models/quiz.dart';
import 'package:courseit/models/video.dart';
import 'package:courseit/screens/quiz_screen.dart';
import 'package:courseit/screens/session_book.dart';
import 'package:courseit/screens/video_player_screen.dart';
import 'package:courseit/utils/constants.dart';
import 'package:courseit/utils/db_connections.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SingleCourseScreen extends StatefulWidget {
  final Course course;

  SingleCourseScreen({this.course});

  @override
  _SingleCourseScreenState createState() => _SingleCourseScreenState();
}

class _SingleCourseScreenState extends State<SingleCourseScreen> {
  bool _isCourseBought = true;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: check(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting ||
              snapshot.connectionState == ConnectionState.none) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          List<Video> videos = List<Video>();
          List<Quiz> quizzes = List<Quiz>();
          List<Quiz> quizMarks = List<Quiz>();
          var resp = snapshot.data;
          print(resp['success']);
          print(resp['data']);
          if (resp['success'] == true && resp['data'].length != 0) {
            List<dynamic> dynamicList = resp['data'][0]['Course']['videos'];
            print(dynamicList.toString());
            dynamicList.forEach((element) {
              videos.add(Video(
                  title: element['Title'],
                  relatedCourse: element['course'],
                  url: element['Vurl'],
                  videoId: element['_id']));
            });
            print(videos[0].title);
            List<dynamic> dynamicList2 = resp['data'][0]['Course']['quiz'];
            List<dynamic> dynamicList3 = resp['data'][0]["quiz_attempted"];
            print(dynamicList3);
            dynamicList2.forEach((element) {
              quizzes.add(
                  Quiz(quizName: element['Title'], quizURL: element['Link']));
            });
            dynamicList3.forEach((element) {
              quizMarks
                  .add(Quiz(marks: element["marks"], quizName: element['_id']));
            });
            print(quizzes[0].quizName);
            _isCourseBought = true;
          } else {
            _isCourseBought = false;
          }
          return Scaffold(
            appBar: AppBar(
              title: AutoSizeText(
                widget.course.name,
                style: kHeaderStyle,
              ),
              centerTitle: true,
            ),
            body: !_isCourseBought
                ? ListView(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            child: Image.network(widget.course.thumbnail),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            widget.course.name,
                            style: kTitleStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: AutoSizeText(
                              widget.course.description,
                              style: kNormalTextStyle,
                              textAlign: TextAlign.center,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Authored by : ${widget.course.publisher}',
                            style: kAuthorTextStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Date published : ${widget.course.publishedDate}',
                            style: kAuthorTextStyle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Center(
                            child: RaisedButton(
                              child: Text(
                                'Enroll',
                                style: kButtonText,
                              ),
                              color: kButtonColor,
                              onPressed: () async {
                                var pref =
                                    await SharedPreferences.getInstance();
                                String token = pref.getString(kStatusText);
                                var resp = await DBConnections().enrollInCourse(
                                    courseId: widget.course.courseid,
                                    token: token);
                                resp = jsonDecode(resp);
                                if (resp['success'] == true) {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            SingleCourseScreen(
                                          course: widget.course,
                                        ),
                                      ));
                                }
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  )
                : DefaultTabController(
                    length: 2,
                    child: Scaffold(
                      appBar: TabBar(
                        labelColor: Colors.black,
                        tabs: [
                          Tab(
                            child: Text(
                              'Course',
                              style: kTitleStyle,
                            ),
                          ),
                          Tab(
                            child: Text(
                              'Course Analytics',
                              style: kTitleStyle,
                            ),
                          )
                        ],
                      ),
                      body: TabBarView(
                        children: [
                          ListView(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 150,
                                    width: 150,
                                    child:
                                        Image.network(widget.course.thumbnail),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    widget.course.name,
                                    style: kTitleStyle,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 20),
                                    child: AutoSizeText(
                                      widget.course.description,
                                      style: kNormalTextStyle,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'Authored by : ${widget.course.publisher}',
                                    style: kAuthorTextStyle,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Divider(
                                height: 5,
                                color: Colors.teal[300],
                              ),
                              Center(
                                child: Text(
                                  'Videos',
                                  style: kTitleStyle,
                                ),
                              ),
                              videos.length == 0
                                  ? Center(
                                      child: Text(
                                        'No videos',
                                        style: kTitleStyle,
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: videos.length,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: EdgeInsets.all(10),
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(20)),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            VideoPlayerScreen(
                                                              videoUrl:
                                                                  videos[index]
                                                                      .url,
                                                            )));
                                              },
                                              splashColor:
                                                  Colors.teal.withAlpha(30),
                                              child: ListTile(
                                                title: Text(
                                                  '${index + 1}: ' +
                                                      videos[index].title,
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                              quizzes.length == 0
                                  ? Center(
                                      child: Text(
                                        'No quizzes',
                                        style: kTitleStyle,
                                      ),
                                    )
                                  : ListView.builder(
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: quizzes.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        QuizScreen(
                                                          quizLink:
                                                              quizzes[index]
                                                                  .quizURL,
                                                        )));
                                          },
                                          child: Center(
                                            child: Text(
                                              quizzes[index].quizName,
                                              style: TextStyle(
                                                  color: Colors.pink,
                                                  fontSize: 20,
                                                  fontStyle: FontStyle.italic),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                              Center(
                                child: RaisedButton(
                                  child: Text(
                                    'Book a session',
                                    style: kButtonText,
                                  ),
                                  color: kButtonColor,
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                SessionBookingScreen()));
                                  },
                                ),
                              )
                            ],
                          ),
                          Center(
                            child: quizMarks.length == 0
                                ? Text(
                                    'No quizzes yet!',
                                    style: kTitleStyle,
                                  )
                                : SfCartesianChart(
                                    primaryXAxis: CategoryAxis(),
                                    primaryYAxis: NumericAxis(),
                                    series: <BarSeries<Quiz, String>>[
                                      BarSeries<Quiz, String>(
                                          dataSource: quizMarks,
                                          xValueMapper: (Quiz quiz, _) =>
                                              quiz.quizName,
                                          yValueMapper: (Quiz quiz, _) =>
                                              quiz.marks,
                                          dataLabelSettings: DataLabelSettings(
                                              isVisible: true),
                                          color: Colors.teal,
                                          width: 0.35)
                                    ],
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ),
          );
        });
  }

  Future check() async {
    var pref = await SharedPreferences.getInstance();
    String token = pref.getString(kStatusText);
    var resp = await DBConnections()
        .checkCourseAndUser(courseId: widget.course.courseid, token: token);
    resp = jsonDecode(resp);
    return resp;
  }
}
