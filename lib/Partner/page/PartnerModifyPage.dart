import 'package:flutter/material.dart';
import '../model/Partner.dart';
import '../page/PartnerDetailPage.dart';

class PartnerModifyPage extends StatefulWidget {
  final Partner partner;

  PartnerModifyPage({required this.partner});

  @override
  _PartnerModifyPageState createState() => new _PartnerModifyPageState(partner: partner);
}

class _PartnerModifyPageState extends State<PartnerModifyPage> {
  final Partner partner;

  _PartnerModifyPageState({required this.partner});

  @override
  Widget build(BuildContext context) {
    var _companyName = partner.companyName;
    var _phoneNumber = partner.phoneNumber;
    var _ceoName = partner.ceoName;

    return new Scaffold(
      appBar: new AppBar(
        title: new Text('거래처 수정'),
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
                  decoration: InputDecoration(
                    labelText: _companyName,
                  ),
                  onChanged: (text){
                    if (text.trim().isNotEmpty) {
                      _companyName = text;
                    } else {
                      _companyName = partner.companyName;
                    }
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
                  decoration: InputDecoration(
                    labelText: _phoneNumber,
                  ),
                  onChanged: (text){
                    if (text.trim().isNotEmpty) {
                      _phoneNumber = text;
                    } else {
                      _phoneNumber = partner.phoneNumber;
                    }
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
                  decoration: InputDecoration(
                    labelText: _ceoName,
                  ),
                  onChanged: (text){
                    if (text.trim().isNotEmpty) {
                      _ceoName = text;
                    } else {
                      _ceoName = partner.ceoName;
                    }
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
                    "수정",
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