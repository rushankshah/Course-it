import 'package:courseit/models/User.dart';
import 'package:courseit/screens/home_screen.dart';
import 'package:courseit/screens/register_page.dart';
import 'package:courseit/utils/constants.dart';
import 'package:courseit/utils/db_connections.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  bool _isLoggingIn = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Course it',
          style: kHeaderStyle,
        ),
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Text(
                    'Login',
                    style: kTitleStyle,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Center(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: TextFormField(
                            validator: (String value) {
                              if (value.isEmpty)
                                return 'Email is a required field';
                              return null;
                            },
                            onSaved: (String value) {
                              _email = value;
                            },
                            style: kTextField,
                            decoration: InputDecoration(
                                labelText: 'Enter Email',
                                labelStyle: kTextFieldLabelText),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: TextFormField(
                            validator: (String value) {
                              if (value.isEmpty)
                                return 'Password is a required field';
                              return null;
                            },
                            onSaved: (String value) {
                              _password = value;
                            },
                            style: kTextField,
                            obscureText: true,
                            decoration: InputDecoration(
                              labelText: 'Enter password',
                              labelStyle: kTextFieldLabelText,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(height: 10),
                        Center(
                          child: RaisedButton(
                            child: Text(
                              'Submit',
                              style: kButtonText,
                            ),
                            color: kButtonColor,
                            onPressed: () async {
                              if (!_formKey.currentState.validate()) return;
                              _formKey.currentState.save();
                              setState(() {
                                _isLoggingIn = true;
                              });
                              var resp = await DBConnections()
                                  .verifyUser(_email, _password);
                              if (resp['token'] != null) {
                                Fluttertoast.showToast(msg: 'Login successful');
                                var id = resp['token'];
                                final pref =
                                    await SharedPreferences.getInstance();
                                await pref.setString(
                                    kStatusText, id.toString());
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()));
                              } else {
                                setState(() {
                                  _isLoggingIn = false;
                                });
                                Fluttertoast.showToast(
                                    msg: 'Credentials incorrect');
                              }
                            },
                          ),
                        ),
                        Center(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Not a user?',
                              style: kNormalTextStyle,
                            ),
                            GestureDetector(
                              child: Text(
                                'Register!',
                                style: GoogleFonts.montserrat(
                                    fontSize: 18, color: Colors.lightBlue),
                              ),
                              onTap: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => RegisterScreen()));
                              },
                            )
                          ],
                        )),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          _isLoggingIn
              ? Container(
                  alignment: FractionalOffset.center,
                  child: CircularProgressIndicator(),
                )
              : Container()
        ],
      ),
    );
  }
}
