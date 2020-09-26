import 'package:courseit/models/User.dart';
import 'package:courseit/screens/login_page.dart';
import 'package:courseit/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _name;
  String _email;
  String _password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Course it',
          style: kHeaderStyle,
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Text(
                'Register your details',
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
                          if (value.isEmpty) return 'Name is a required field';
                          return null;
                        },
                        onSaved: (String value) {
                          _name = value;
                        },
                        style: kTextField,
                        decoration: InputDecoration(
                            labelText: 'Enter Name',
                            labelStyle: kTextFieldLabelText),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 30, right: 30),
                      child: TextFormField(
                        validator: (String value) {
                          if (value.isEmpty) return 'Email is a required field';
                          if (!RegExp(
                                  r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                              .hasMatch(value)) return 'Incorrect email';
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
                          if (!RegExp(
                                  r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
                              .hasMatch(value))
                            return 'Password \n 1.Should contain at least one upper case \n 2.Should contain at least one lower case \n 3.Should contain at least one digit \n 4.Should contain at least one Special character';
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
                        onPressed: () {
                          if (!_formKey.currentState.validate()) return;
                          _formKey.currentState.save();
                          User user = User(
                              email: _email, password: _password, name: _name);
                          print(user);
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Already a user?',
                    style: kNormalTextStyle,
                  ),
                  GestureDetector(
                    child: Text(
                      'Login!',
                      style: GoogleFonts.montserrat(
                        fontSize: 18,
                        color: Colors.lightBlue
                      ),
                    ),
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                    },
                  )
                ],
              )
            )
          ],
        ),
      ),
    );
  }
}
