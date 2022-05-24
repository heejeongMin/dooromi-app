import 'package:dooromi/User/function/AuthApi.dart';
import 'package:dooromi/User/model/AuthToken.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../main.dart';
import '../model/DetailUser.dart';

import '../../HeavyEquipment/page/HeavyEquipmentListPage.dart';
import 'LoginPage.dart';

class UserProfilePage extends StatefulWidget {
  final DetailUser user;

  UserProfilePage({required this.user});

  @override
  _UserProfilePageState createState() => new _UserProfilePageState(user: user);
}

class _UserProfilePageState extends State<UserProfilePage> {
  final DetailUser user;
  final NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');


  _UserProfilePageState({required this.user});

  @override
  Widget build(BuildContext context) {
    if (AuthToken.token == null || AuthToken.token.isEmpty) {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => new LoginPage()),
          (route) => false);
    }

    return new Scaffold(
        appBar: new AppBar(
          title: new Text('프로필'),
        ),
        body: new SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(40),
          child: new Container(
            child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[

                      ]),
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        new Column(
                          children: [
                            new Icon(Icons.person,
                                color: Colors.orange, size: 80.0),
                          ],
                        ),
                        SizedBox(
                          width : 20,
                          height : 20
                        ),
                        new Column(
                          children: [
                            new Text(
                              AuthToken.user.fullname,
                              style: new TextStyle(
                                  fontSize: 25.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Roboto"),
                            ),
                          ],
                        ),
                      ]),
                  SizedBox(
                      height : 10
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        AuthToken.user.fullname + "님의 기본정보",
                        style: new TextStyle(
                            fontSize: 18.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            fontFamily: "Roboto"),
                      ),
                      SizedBox(
                        width: 45,
                      ),
                      SizedBox(
                        width: 70,
                        height: 18,
                        child: ElevatedButton(
                          child: Text(
                            "로그아웃",
                            style: new TextStyle(
                                fontSize: 10.0,
                                color: const Color(0xFF000000),
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto"),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.black.withOpacity(0.05),
                            ),
                            overlayColor:
                            MaterialStateProperty.all(Colors.orange),
                          ),
                          onPressed: () {
                            AuthToken.token = null;
                            AuthToken.user = new DetailUser("", "", "", "", "");
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                    new DooroomiNavigator()),
                                    (route) => false);
                          },
                        ),
                      )
                    ],
                  ),
                  new Divider(
                    color : Colors.brown,
                    height: 10,
                    thickness: 1.5,
                  ),
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        new Column(
                          children: [
                            new Text(
                              "    아이디       ",
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w200,
                                  fontFamily: "Roboto"),
                            ),
                          ],
                        ),
                        new Column(
                          children: [
                            new Text(
                              AuthToken.user.username,
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Roboto"),
                            ),
                          ],
                        ),
                      ]),
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        new Column(
                          children: [
                            new Text(
                              "    이메일       ",
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w200,
                                  fontFamily: "Roboto"),
                            ),
                          ],
                        ),
                        new Column(
                          children: [
                            new Text(
                              AuthToken.user.email,
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Roboto"),
                            ),
                          ],
                        ),
                      ]),
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        new Column(
                          children: [
                            new Text(
                              "    가입일자   ",
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w200,
                                  fontFamily: "Roboto"),
                            ),
                          ],
                        ),
                        new Column(
                          children: [
                            new Text(
                              AuthToken.user.joinedAt,
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w300,
                                  fontFamily: "Roboto"),
                            ),
                          ],
                        ),
                      ]),
                  SizedBox(
                    height: 10,
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      SizedBox(
                        width: 80,
                        height: 18,
                        child: ElevatedButton(
                          child: Text(
                            "이메일변경",
                            style: new TextStyle(
                                fontSize: 10.0,
                                color: const Color(0xFF000000),
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto"),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.black.withOpacity(0.05),
                            ),
                            overlayColor:
                            MaterialStateProperty.all(Colors.orange),
                          ),
                          onPressed: () {
                            AuthApi.changeEmail(context);
                          },
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 90,
                        height: 18,
                        child: ElevatedButton(
                          child: Text(
                            "비밀번호변경",
                            style: new TextStyle(
                                fontSize: 10.0,
                                color: const Color(0xFF000000),
                                fontWeight: FontWeight.w400,
                                fontFamily: "Roboto"),
                          ),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              Colors.black.withOpacity(0.05),
                            ),
                            overlayColor:
                            MaterialStateProperty.all(Colors.orange),
                          ),
                          onPressed: () {
                            AuthApi.changePassword(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  new SizedBox(
                    height: 20,
                  ),
                  new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      new Text(
                        AuthToken.user.fullname + "님의 업무정보 ",
                        style: new TextStyle(
                            fontSize: 18.0,
                            color: Colors.black54,
                            fontWeight: FontWeight.w700,
                            fontStyle: FontStyle.italic,
                            fontFamily: "Roboto"),
                      ),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        icon: const Icon(
                            Icons.refresh,
                            color: Colors.orange, size: 20.0),
                        color: Colors.orange,
                        onPressed: () {
                          AuthApi.updateUserWorkInfo(AuthToken.token);
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                  new Divider(
                    color : Colors.brown,
                    height: 10,
                    thickness: 1.5,
                  ),
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        new Column(
                          children: [
                            new Text(
                              "    보유 장비 수             ",
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w200,
                                  fontFamily: "Roboto"),
                            ),
                          ],
                        ),
                        new Column(
                          children: [
                            new Text(
                              AuthToken.user.userWorkInfo.numberOfHeavyEquipment.toString(),
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w200,
                                  fontFamily: "Roboto"),
                            ),
                          ],
                        ),
                      ]),
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        new Column(
                          children: [
                            new Text(
                              "    보유 거래처 수         ",
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w200,
                                  fontFamily: "Roboto"),
                            ),
                          ],
                        ),
                        new Column(
                          children: [
                            new Text(
                              AuthToken.user.userWorkInfo.numberOfPartners.toString(),
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w200,
                                  fontFamily: "Roboto"),
                            ),
                          ],
                        ),
                      ]),
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        new Column(
                          children: [
                            new Text(
                              "    이번 달 근무 일수    ",
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w200,
                                  fontFamily: "Roboto"),
                            ),
                          ],
                        ),
                        new Column(
                          children: [
                            new Text(
                              AuthToken.user.userWorkInfo.workDaysOfTheMonth.toString(),
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w200,
                                  fontFamily: "Roboto"),
                            ),
                          ],
                        ),
                      ]),
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        new Column(
                          children: [
                            new Text(
                              "    이번 달 총 수입        ",
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w200,
                                  fontFamily: "Roboto"),
                            ),
                          ],
                        ),
                        new Column(
                          children: [
                            new Text(
                              numberFormat.format(AuthToken.user.userWorkInfo.workPayOfTheMonth),
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w200,
                                  fontFamily: "Roboto"),
                            ),
                          ],
                        ),
                      ]),
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        new Column(
                          children: [
                            new Text(
                              "    지난 달 근무 일수    ",
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w200,
                                  fontFamily: "Roboto"),
                            ),
                          ],
                        ),
                        new Column(
                          children: [
                            new Text(
                              AuthToken.user.userWorkInfo.workDaysOfLastMonth.toString(),
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w200,
                                  fontFamily: "Roboto"),
                            ),
                          ],
                        ),
                      ]),
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        new Column(
                          children: [
                            new Text(
                              "    지난 달 총 수입        ",
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w200,
                                  fontFamily: "Roboto"),
                            ),
                          ],
                        ),
                        new Column(
                          children: [
                            new Text(
                              numberFormat.format(AuthToken.user.userWorkInfo.workPayOfLastMonth),
                              style: new TextStyle(
                                  fontSize: 15.0,
                                  color: const Color(0xFF000000),
                                  fontWeight: FontWeight.w200,
                                  fontFamily: "Roboto"),
                            ),
                          ],
                        ),
                      ]),
                  new Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        ElevatedButton(
                          child: Text("나의 장비"),
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                settings: RouteSettings(
                                    name: "/HeavyEquipmentListPage"),
                                builder: (context) =>
                                    new HeavyEquipmentListPage()));
                          },
                        ),
                      ])
                ]),
          ),
        ));
  }
}
