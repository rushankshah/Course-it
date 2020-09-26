import 'dart:convert';
import 'package:courseit/models/User.dart';
import 'package:http/http.dart' as http;

class DBConnections {
  static const String homeUrl = 'https://codeitbackend.herokuapp.com/';
  Future verifyUser(String email, String password) async {
    var url = homeUrl + 'api/users/login';
    var response = await http.post(url,
        body:
            jsonEncode(<String, String>{"email": email, "password": password}),
        headers: {"Content-Type": "application/json"});
    print(response.body);
    var output = jsonDecode(response.body);
    return output["found"];
  }

  Future registerUser(User user) async {
    var url = homeUrl + 'api/users/register';
    var response = await http.post(url,
        body: jsonEncode(<String, dynamic>{
          "name": user.name,
          "email": user.email,
          "password": user.password
        }),
        headers: {"Content-Type": "application/json"});
    return response.body;
  }

  Future getAllCourses() async {
    var url = homeUrl + 'api/course/all_courses';
    var response = await http.get(url);
    return response.body;
  }

  Future getUserCourses({String userId}) async {
    var url = homeUrl + 'api/mycourse/';
    var response = await http.get(url, headers: {
      'X-Auth-Token' : userId
    });
    print(response.body);
  }
}
