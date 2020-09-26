import 'dart:async';

import 'package:courseit/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class SessionBookingScreen extends StatefulWidget {
  @override
  _SessionBookingScreenState createState() => _SessionBookingScreenState();
}

class _SessionBookingScreenState extends State<SessionBookingScreen> {
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
          'Book a Session',
          style: kHeaderStyle,
        ),
        centerTitle: true,
      ),
      body: Stack(
          children: <Widget>[
            WebView(
              initialUrl: 'https://calendly.com/rushankshah65/15min',
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