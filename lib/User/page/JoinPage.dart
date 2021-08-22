import 'package:flutter/material.dart';
import '../model/User.dart';
import '../page/UserProfilePage.dart';

class JoinPage extends StatefulWidget {
  @override
  _JoinPageState createState() => new _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  var _name = "";
  var _phoneNumber = "";
  var _birthdate = "";
  var _address = "";
  var _nationality = "";

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
                  new Padding(
                    child:
                    new Text(
                      "이름",
                      style: new TextStyle(fontSize:15.0,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w500,
                          fontFamily: "Roboto"),
                    ),

                    padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 5.0),
                  ),

                  new Padding(
                    child:
                    new TextField(
                      onChanged: (text){
                        _name = text;
                      },
                      style: new TextStyle(fontSize:12.0,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w200,
                          fontFamily: "Roboto"),
                    ),

                    padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 12.0),
                  ),

                  new Padding(
                    child:
                    new Text(
                      "전화번호",
                      style: new TextStyle(fontSize:15.0,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w500,
                          fontFamily: "Roboto"),
                    ),

                    padding: const EdgeInsets.fromLTRB(24.0, 15.0, 24.0, 5.0),
                  ),

                  new Padding(
                    child:
                    new TextField(
                      onChanged: (text){
                        _phoneNumber = text;
                      },
                      style: new TextStyle(fontSize:12.0,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w200,
                          fontFamily: "Roboto"),
                    ),

                    padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 12.0),
                  ),

                  new Padding(
                    child:
                    new Text(
                      "생년월일",
                      style: new TextStyle(fontSize:15.0,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w500,
                          fontFamily: "Roboto"),
                    ),

                    padding: const EdgeInsets.fromLTRB(24.0, 15.0, 24.0, 5.0),
                  ),

                  new Padding(
                    child:
                    new TextField(
                      onChanged: (text){
                        _birthdate = text;
                      },
                      style: new TextStyle(fontSize:12.0,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w200,
                          fontFamily: "Roboto"),
                    ),

                    padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 12.0),
                  ),

                  new Padding(
                    child:
                    new Text(
                      "주소",
                      style: new TextStyle(fontSize:15.0,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w500,
                          fontFamily: "Roboto"),
                    ),

                    padding: const EdgeInsets.fromLTRB(24.0, 15.0, 24.0, 5.0),
                  ),

                  new Padding(
                    child:
                    new TextField(
                      onChanged: (text){
                        _address = text;
                      },
                      style: new TextStyle(fontSize:12.0,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w200,
                          fontFamily: "Roboto"),
                    ),

                    padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 12.0),
                  ),

                  new Padding(
                    child:
                    new Text(
                      "국적",
                      style: new TextStyle(fontSize:15.0,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto"),
                    ),

                    padding: const EdgeInsets.fromLTRB(24.0, 15.0, 24.0, 5.0),
                  ),

                  new Padding(
                    child:
                    new DropdownButton<String>(
                      onChanged: (value) {
                        setState(() {
                          _nationality = value.toString();
                        });
                      },
                      value: "대한민국",
                      style: new TextStyle(fontSize:12.0,
                          color: const Color(0xFF202020),
                          fontWeight: FontWeight.w200,
                          fontFamily: "Roboto"),
                      items: <DropdownMenuItem<String>>[
                        const DropdownMenuItem<String>(value: "대한민국",
                            child: const Text("대한민국")),
                        const DropdownMenuItem<String>(value: "Child 2",
                            child: const Text("Child 2")),
                        const DropdownMenuItem<String>(value: "Child 3",
                            child: const Text("Child 3")),
                      ],
                    ),

                    padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 12.0),
                  ),

                  new Padding(
                    child:
                    new ElevatedButton(
                      //color: const Color(0xFFe0e0e0),
                      child:
                      new Text(
                        "회원가입",
                        style: new TextStyle(fontSize:12.0,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w200,
                            fontFamily: "Roboto"),
                      ),

                      onPressed: () {
                        final user = User(_name, _phoneNumber, _birthdate, _address, _nationality);

                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => new UserProfilePage(user: user))
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