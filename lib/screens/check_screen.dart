import 'package:courseit/screens/home_screen.dart';
import 'package:courseit/screens/register_page.dart';
import 'package:courseit/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckScreen extends StatefulWidget {
  @override
  _CheckScreenState createState() => _CheckScreenState();
}

class _CheckScreenState extends State<CheckScreen> {
  @override
  void initState() {
    super.initState();
    checkUserStatus();
  }

  checkUserStatus() async{
    final pref = await SharedPreferences.getInstance();
    final status = pref.getString(kStatusText);
    if(status == null || status == kLogOutText)
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => RegisterScreen()));
    else
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }
}
