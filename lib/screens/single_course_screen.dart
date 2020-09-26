import 'package:auto_size_text/auto_size_text.dart';
import 'package:courseit/models/course.dart';
import 'package:courseit/screens/video_player_screen.dart';
import 'package:courseit/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SingleCourseScreen extends StatefulWidget {
  final Course course;

  SingleCourseScreen({this.course});

  @override
  _SingleCourseScreenState createState() => _SingleCourseScreenState();
}

class _SingleCourseScreenState extends State<SingleCourseScreen> {
  bool _isCourseBought = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    checkUserAndCourse();
  }

  checkUserAndCourse() {
    setState(() {
      _isCourseBought = true;
    });
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.course.name,
          style: kHeaderStyle,
        ),
        centerTitle: true,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : !_isCourseBought
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
              : ListView(
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
                            borderRadius: BorderRadius.circular(20)),
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => VideoPlayerScreen(
                                          videoPlayerController:
                                              VideoPlayerController.network(
                                                  'https://flutter.github.io/assets-for-api-docs/videos/butterfly.mp4'),
                                        )));
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
                  ],
                ),
    );
  }
}
