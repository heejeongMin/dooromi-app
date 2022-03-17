import 'package:dooromi/User/function/AuthApi.dart';
import 'package:dooromi/User/model/SigninUser.dart';
import 'package:flutter/material.dart';

import 'JoinPage.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _username = "";
  var _password = "";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('로그인'),
      ),
      body:
      SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child:
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30.0, bottom: 30.0),
              child: Center(
                child: Container(
                    width: 180,
                    height: 130,
                    /*decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(50.0)),*/
                    child: Image.asset('assets/image/logo.png')
                ),
              ),
            ),
            Padding(
              //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
              padding: const EdgeInsets.only(
                  left: 60.0, right: 60.0, top: 10, bottom: 0),
              child: TextFormField(
                onChanged: (text){
                  _username = text;
                },
                style: TextStyle(
                    fontSize: 15.0,
                    height: 1.0
                ),
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '아이디'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 60.0, right: 60.0, top: 10, bottom: 30),
              child: TextFormField(
                onChanged: (text){
                  _password = text;
                },
                style: TextStyle(
                    fontSize: 15.0,
                    height: 1.0
                ),
                obscureText: true,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: '비밀번호'),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                ElevatedButton(
                  child: Text("회원가입"),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(
                            settings: RouteSettings(name: "/JoinPage"),
                            builder: (context) => new JoinPage()
                        ));
                  },
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  child: Text("로그인"),
                  onPressed: () {
                    AuthApi.signin(
                        new SigninUser(_username, _password), context);
                  },
                ),
              ],
            ),
          ])
      )
    );
  }
}