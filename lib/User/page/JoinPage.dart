import 'package:dooromi/User/function/AuthApi.dart';
import 'package:flutter/material.dart';
import '../model/CreateUser.dart';

class JoinPage extends StatefulWidget {
  @override
  _JoinPageState createState() => new _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  var _username = "";
  var _password = "";
  var _fullname = "";
  var _email = "";


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('회원가입'),
      ),
      body:
      new SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(40),
          child:
          new Container(
            child:
            new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 30, bottom: 15),
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
                        left: 30.0, right: 30.0, top: 0, bottom: 15),
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
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 0, bottom: 15),
                    child: TextFormField(
                      onChanged: (text){
                        _fullname = text;
                      },
                      style: TextStyle(
                          fontSize: 15.0,
                          height: 1.0
                      ),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '이름'),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 0, bottom: 15),
                    child: TextFormField(
                      onChanged: (text){
                        _email = text;
                      },
                      style: TextStyle(
                          fontSize: 15.0,
                          height: 1.0
                      ),
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '이메일'),
                    ),
                  ),

                  new Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      padding: const EdgeInsets.only(
                          left: 30.0, right: 30.0, top: 0, bottom: 15),
                      alignment: Alignment.centerRight,
                      child:
                      ElevatedButton(
                        child: Text('회원가입'),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.indigo),
                        onPressed: () {
                          AuthApi.createUser(
                              new CreateUser(_username, _password, _fullname, _email),
                              context);
                        },
                      )
                  ),
                ]
            ),
          ),
      )
    );
  }
}