import 'package:dooromi/Partner/funciton/PartnerApi.dart';
import 'package:dooromi/Partner/model/Partner.dart';
import 'package:flutter/material.dart';

class PartnerCreatePage extends StatefulWidget {

  @override
  _PartnerCreatePageState createState() =>
      new _PartnerCreatePageState();
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

                  padding: const EdgeInsets.fromLTRB(24.0, 10.0, 24.0, 0.0),
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

                  padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
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
                  padding: const EdgeInsets.fromLTRB(24.0, 15.0, 24.0, 0.0),
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

                  padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 24.0),
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

                  padding: const EdgeInsets.fromLTRB(24.0, 15.0, 24.0, 0.0),
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

                  padding: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 10.0),
                ),
                new Container(
                    margin: const EdgeInsets.only(top: 16.0),
                    padding: const EdgeInsets.all(5.0),
                    alignment: Alignment.centerRight,
                    child:
                    ElevatedButton(
                      child: Text('저장'),
                      onPressed: () {
                        final partner = Partner(_companyName, _ceoName, _phoneNumber);

                        showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext newContext) {
                              return AlertDialog(
                                title: Text('파트너 저장'),
                                content: SingleChildScrollView(
                                  child: ListBody(
                                    children: [
                                      Text('해당 내용으로 저장하시겠습니까?'),
                                      Text(partner.forDialog())
                                    ],
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    child: Text('저장'),
                                    onPressed: (){
                                      Navigator.of(context, rootNavigator: true).pop();
                                      PartnerApi.createPartner(partner, context);
                                    },
                                  ),
                                  TextButton(
                                    child: Text('취소'),
                                    onPressed: (){
                                      Navigator.of(context, rootNavigator: true).pop();
                                    },
                                  ),
                                ],
                              );
                            }
                        );
                      },
                    )
                ),
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