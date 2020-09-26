import 'dart:async';

import 'package:courseit/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class QuizScreen extends StatefulWidget {
  final String quizLink;
  QuizScreen({this.quizLink});
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  bool _isPageLoading;
  @override
  void initState() {
    super.initState();
    _isPageLoading = true;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Give the quiz',
          style: kHeaderStyle,
        ),
        centerTitle: true,
      ),
      body: Stack(
          children: <Widget>[
            WebView(
              initialUrl: widget.quizLink,
              javascriptMode: JavascriptMode.unrestricted,
              onWebViewCreated: (WebViewController c){
                _controller.complete(c);
              },
              onPageFinished: (finish){
                setState(() {
                  _isPageLoading = false;
                });
              },
            ),
            _isPageLoading ? Container(
              alignment: FractionalOffset.center,
              child: CircularProgressIndicator(),
            ) : Container()
          ],
        ),
    );
  }
}