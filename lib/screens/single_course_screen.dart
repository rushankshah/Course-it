import 'package:auto_size_text/auto_size_text.dart';
import 'package:courseit/models/course.dart';
import 'package:courseit/models/quiz.dart';
import 'package:courseit/screens/session_book.dart';
import 'package:courseit/screens/video_player_screen.dart';
import 'package:courseit/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class SingleCourseScreen extends StatefulWidget {
  final Course course;

  SingleCourseScreen({this.course});

  @override
  _SingleCourseScreenState createState() => _SingleCourseScreenState();
}

class _SingleCourseScreenState extends State<SingleCourseScreen> {
  bool _isCourseBought = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.waiting || snapshot.connectionState == ConnectionState.none){
          return Center(child: CircularProgressIndicator(),);
        }
        
        return Scaffold(
          appBar: AppBar(
            title: Text(
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
                              padding:
                                  const EdgeInsets.only(left: 20, right: 20),
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
                            Text(
                              'Price : ₹ ${widget.course.price}',
                              style: kTitleStyle,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Center(
                              child: RaisedButton(
                                child: Text(
                                  'Buy now!!',
                                  style: kButtonText,
                                ),
                                color: kButtonColor,
                                onPressed: () {},
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
                                      child: Image.network(
                                          widget.course.thumbnail),
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
                                Padding(
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
                                                    VideoPlayerScreen()));
                                      },
                                      splashColor: Colors.teal.withAlpha(30),
                                      child: ListTile(
                                        title: Text(
                                          '1: Video 1',
                                        ),
                                      ),
                                    ),
                                  ),
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
                              child: SfCartesianChart(
                                primaryXAxis: CategoryAxis(),
                                primaryYAxis: NumericAxis(),
                                series: <BarSeries<Quiz, String>>[
                                  BarSeries<Quiz, String>(
                                      dataSource: <Quiz>[
                                        Quiz(quizName: 'Quiz 1', marks: 10),
                                        Quiz(quizName: 'Quiz 2', marks: 3),
                                        Quiz(quizName: 'Quiz 3', marks: 5),
                                      ],
                                      xValueMapper: (Quiz quiz, _) =>
                                          quiz.quizName,
                                      yValueMapper: (Quiz quiz, _) =>
                                          quiz.marks,
                                      dataLabelSettings:
                                          DataLabelSettings(isVisible: true),
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
      },
    );
  }
}
