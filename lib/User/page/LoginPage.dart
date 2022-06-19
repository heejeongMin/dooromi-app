import 'package:dooromi/User/function/AuthApi.dart';
import 'package:dooromi/User/model/SigninUser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


import 'JoinPage.dart';


class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _username = "";
  var _password = "";
  String? userInfo = ""; //user의 정보를 저장하기 위한 변수

  static final storage = new FlutterSecureStorage(); //flutter_secure_storage 사용을 위한 초기화 작업

  @override
  void initState() {
    super.initState();
    //비동기로 flutter secure storage 정보를 불러오는 작업.
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      _asyncMethod();
    });
  }

  _asyncMethod() async {
    //read 함수를 통하여 key값에 맞는 정보를 불러오게 됩니다. 이때 불러오는 결과의 타입은 String 타입임을 기억해야 합니다.
    //(데이터가 없을때는 null을 반환을 합니다.)
    userInfo = await storage.read(key: "signin");
    print(userInfo);

    //user의 정보가 있다면 바로 로그아웃 페이지로 넝어가게 합니다.
    if (userInfo != null) {
      AuthApi.signin(
          new SigninUser(userInfo!.split(",")[1], userInfo!.split(",")[3]),
          context,
          storage);
    }
  }

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
                  style: ElevatedButton.styleFrom(
                      primary: Colors.indigo),
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
                  style: ElevatedButton.styleFrom(
                      primary: Colors.indigo),
                  onPressed: () {
                    AuthApi.signin(
                        new SigninUser(_username, _password), context, storage);
                  },
                ),
              ],
            ),
          ])
      )
    );
  }
}