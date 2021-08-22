import 'package:flutter/material.dart';
import '../model/User.dart';
import '../page/UserModifyPage.dart';
import 'package:dooromi/Partner/page/PartnerListPage.dart';

class UserProfilePage extends StatefulWidget {
  final User user;

  UserProfilePage({required this.user});

  @override
  _UserProfilePageState createState() => new _UserProfilePageState(user: user);
}

class _UserProfilePageState extends State<UserProfilePage> {
  final User user;

  _UserProfilePageState({required this.user});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('프로필'),
      ),
      body:
      new SingleChildScrollView(
      scrollDirection: Axis.vertical,
      padding: const EdgeInsets.all(40),
      child:
      new Container(
        child:
        new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Padding(
                child:
                new Icon(
                    Icons.person,
                    color: const Color(0xFF000000),
                    size: 200.0),

                padding: const EdgeInsets.fromLTRB(24.0, 50.0, 24.0, 24.0),
              ),

              new Center(
                child: new Padding(
                  child:
                  new Text(
                    user.name,
                    style: new TextStyle(fontSize:38.0,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w400,
                        fontFamily: "Roboto"),
                  ),

                  padding: const EdgeInsets.fromLTRB(24.0, 10.0, 24.0, 24.0),
                ),
              ),

              new Center(
                child: new Padding(
                  child:
                  new Text(
                    user.phoneNumber,
                    style: new TextStyle(fontSize:23.0,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w200,
                        fontFamily: "Roboto"),
                  ),

                  padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
                ),
              ),

              new Padding(
                child:
                new ElevatedButton(
                  child:
                  new Text(
                    "정보수정",
                    style: new TextStyle(fontSize:12.0,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w200,
                        fontFamily: "Roboto"),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => new UserModifyPage(user: user))
                    );
                  },
                ),

                padding: const EdgeInsets.all(24.0),
              )

              // 임시로 거래처 관리 버튼 생성 - TODO - 위치 옮기기
              ,new Padding(
                child:
                new ElevatedButton(
                  child:
                  new Text(
                    "거래처 관리",
                    style: new TextStyle(fontSize:12.0,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w200,
                        fontFamily: "Roboto"),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => new PartnerListPage())
                    );
                  },
                ),

                padding: const EdgeInsets.all(24.0),
              )
            ]

        ),

        padding: const EdgeInsets.all(0.0),
        alignment: Alignment.center,
      ),
      )


    );
  }

}