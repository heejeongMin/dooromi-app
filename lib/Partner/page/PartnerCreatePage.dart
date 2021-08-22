import 'package:flutter/material.dart';
import '../model/Partner.dart';
import '../page/PartnerDetailPage.dart';

class PartnerCreatePage extends StatefulWidget {
  @override
  _PartnerCreatePageState createState() => new _PartnerCreatePageState();
}

class _PartnerCreatePageState extends State<PartnerCreatePage> {
  var _companyName = "";
  var _phoneNumber = "";
  var _ceoName = "";

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('거래처 등록'),
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
                    "거래처 이름",
                    style: new TextStyle(fontSize:15.0,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w500,
                        fontFamily: "Roboto"),
                  ),

                  padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 5.0),
                ),

                new Padding(
                  child:
                  new TextField(
                    onChanged: (text){
                      _companyName = text;
                    },
                    style: new TextStyle(fontSize:12.0,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w200,
                        fontFamily: "Roboto"),
                  ),

                  padding: const EdgeInsets.fromLTRB(24.0, 15.0, 24.0, 24.0),
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

                  padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 5.0),
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

                  padding: const EdgeInsets.fromLTRB(24.0, 15.0, 24.0, 24.0),
                ),

                new Padding(
                  child:
                  new Text(
                    "대표자 이름",
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
                      _ceoName = text;
                    },
                    style: new TextStyle(fontSize:12.0,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w200,
                        fontFamily: "Roboto"),
                  ),

                  padding: const EdgeInsets.fromLTRB(24.0, 15.0, 24.0, 35.0),
                ),

                new Padding(
                  child:
                  new ElevatedButton(
                    child:
                    new Text(
                      "등록",
                      style: new TextStyle(fontSize:12.0,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w200,
                          fontFamily: "Roboto"),
                    ),

                    onPressed: () {
                      final partner = Partner(_companyName, _phoneNumber, _ceoName);

                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => new PartnerDetailPage(partner: partner))
                      );
                    },
                  ),

                  padding: const EdgeInsets.fromLTRB(24.0, 40.0, 24.0, 24.0),
                )
              ]

          ),

          padding: const EdgeInsets.all(0.0),
          alignment: Alignment.center,
        ),
      )


    );
  }
  void buttonPressed(){}

}