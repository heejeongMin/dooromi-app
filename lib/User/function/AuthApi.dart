import 'dart:convert';

import 'package:dooromi/User/model/AuthToken.dart';
import 'package:dooromi/User/model/CreateUser.dart';
import 'package:dooromi/User/model/DetailUser.dart';
import 'package:dooromi/User/model/SigninUser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class AuthApi {
  static final localHost = '10.0.2.2:5000';
  static final herokuHost = 'peaceful-mesa-17441.herokuapp.com';
  static final authUri = '/auth/';

  static createUser(CreateUser user, BuildContext context) async {
    if (!user.validate()) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(''),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text("모든 정보를 입력하여주세요"),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
              ],
            );
          });
      return;
    }

    Future<http.Response> response = createUserWithPOST(user);

    response.then((value) {
      if (value.statusCode != 201) {
        print(value);
      }
      String message =
          value.statusCode == 201 ? "회원가입이 완료되었습니다." : "회원가입에 실패하였습니다.";

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(''),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(message),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => new DooroomiNavigator()),
                        (route) => false);
                  },
                ),
              ],
            );
          });
    });
  }

  static Future<http.Response> createUserWithPOST(CreateUser user) async {
    return await http.post(Uri.http(localHost, authUri + "signup"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson()));
  }

  static signin(SigninUser user, BuildContext context) async {
    if (!user.validate()) {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(''),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text("아이디 및 비밀번호를 입력하세요"),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                  },
                ),
              ],
            );
          });
      return;
    }

    Future<http.Response> response = signinWithPost(user);

    response.then((value) async {
      if (value.statusCode != 200) {
        print(value);
      }
      String message = value.statusCode == 200 ? "환영합니다!" : "로그인에 실패하였습니다 :(";

      var token = jsonDecode(utf8.decode(value.bodyBytes))['token'];

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(''),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(message),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    // Navigator.pushAndRemoveUntil(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => new DooroomiNavigator(token : token)),
                    //     (route) => false);
                  },
                ),
              ],
            );
          });

      final userDetailResponse = await http.get(
          Uri.http(localHost, authUri + "user/detail"),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'Authorization': 'Bearer ' + token
          });

      DetailUser detailUser = DetailUser.fromJson(
          jsonDecode(utf8.decode(userDetailResponse.bodyBytes)));

      AuthToken.token = token;
      AuthToken.user = detailUser;

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => new DooroomiNavigator()),
          (route) => true);
    });
  }

  static Future<http.Response> signinWithPost(SigninUser user) async {
    return await http.post(Uri.http(localHost, authUri + "signin"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(user.toJson()));
  }

  static changeEmail(BuildContext context) async {
    var email = '';
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('변경할 이메일을 입력하세요'),
            content: TextField(
              onChanged: (value) {
                email = value;
              },
              decoration: InputDecoration(hintText: "email"),
            ),
            actions: [
              TextButton(
                child: Text('변경'),
                onPressed: () {
                  Future<http.Response> response = changeEmailWithPUT(email);

                  response.then((value) {
                    String message = "이메일 변경에 실패하였습니다";

                    if (value.statusCode == 200) {
                      AuthToken.user.email = email;
                      message = "성공적으로 변경하였습니다.";
                    } else {
                      print(value);
                    }

                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(''),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: [
                                  Text(message),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              new DooroomiNavigator()),
                                      (route) => false);
                                },
                              ),
                            ],
                          );
                        });
                  });
                },
              ),
            ],
          );
        });
  }

  static Future<http.Response> changeEmailWithPUT(String email) async {
    print(jsonEncode({"email": email.trim()}));
    return await http.put(Uri.http(localHost, authUri + "email"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + AuthToken.token
        },
        body: jsonEncode({"email": email.trim()}));
  }

  static changePassword(BuildContext context) async {
    var password = '';
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('새로운 비밀번호를 입력하세요'),
            content: TextField(
              onChanged: (value) {
                password = value;
              },
              obscureText: true,
              decoration: InputDecoration(hintText: "비밀번호"),
            ),
            actions: [
              TextButton(
                child: Text('변경'),
                onPressed: () {
                  Future<http.Response> response =
                      changePasswordWithPUT(password);

                  response.then((value) {
                    String message = "비밀번호 변경에 실패하였습니다";

                    if (value.statusCode == 200) {
                      message = "성공적으로 변경하였습니다. 다시 로그인해 주세요";
                    } else {
                      print(value);
                    }

                    showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text(''),
                            content: SingleChildScrollView(
                              child: ListBody(
                                children: [
                                  Text(message),
                                ],
                              ),
                            ),
                            actions: [
                              TextButton(
                                child: Text('OK'),
                                onPressed: () {
                                  AuthToken.token = null;
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();

                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              new DooroomiNavigator()),
                                      (route) => false);
                                },
                              ),
                            ],
                          );
                        });
                  });
                },
              ),
            ],
          );
        });
  }

  static Future<http.Response> changePasswordWithPUT(String password) async {
    return await http.put(Uri.http(localHost, authUri + "password"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + AuthToken.token
        },
        body: jsonEncode({"password": password.trim()}));
  }
}
