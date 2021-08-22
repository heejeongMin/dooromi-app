import 'package:flutter/material.dart';
import '../model/Partner.dart';
import '../page/PartnerModifyPage.dart';

class PartnerDetailPage extends StatefulWidget {
  final Partner partner;

  PartnerDetailPage({required this.partner});

  @override
  _PartnerDetailPageState createState() => new _PartnerDetailPageState(partner: partner);
}

class _PartnerDetailPageState extends State<PartnerDetailPage> {
  final Partner partner;

  _PartnerDetailPageState({required this.partner});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('거래처 상세보기'),
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
              _buildTop(),
              _buildBottom(),
              Padding(
                child:
                new ElevatedButton(
                  child:
                  new Text(
                    "거래처 수정",
                    style: new TextStyle(fontSize:12.0,
                        color: const Color(0xFF000000),
                        fontWeight: FontWeight.w200,
                        fontFamily: "Roboto"),
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => new PartnerModifyPage(partner: partner))
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

  Widget _buildTop() {
    return new Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new Padding(
            child:
            new Icon(
                Icons.contact_phone,
                color: const Color(0xFF000000),
                size: 48.0),

            padding: const EdgeInsets.all(24.0),
          ),

          new Padding(
            child:
            new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  new Padding(
                    child:
                    new Text(
                      partner.companyName,
                      style: new TextStyle(fontSize: 25.0,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w500,
                          fontFamily: "Roboto"),
                    ),

                    padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
                  ),

                  new Padding(
                    child:
                    new Text(
                      partner.phoneNumber,
                      style: new TextStyle(fontSize: 20.0,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto"),
                    ),

                    padding: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
                  ),

                  new Padding(
                    child:
                    new Text(
                      partner.ceoName,
                      style: new TextStyle(fontSize: 20.0,
                          color: const Color(0xFF000000),
                          fontWeight: FontWeight.w400,
                          fontFamily: "Roboto"),
                    ),

                    padding: const EdgeInsets.all(24.0),
                  )
                ]

            ),

            padding: const EdgeInsets.all(24.0),
          ),
        ]
    );
  }

  Widget _buildBottom() {
    final items = List.generate(10, (i) {     // List.generate() 함수는 0부터 9까지의 수(10개)를 생성하여 두 번째 인수의 함수에 i 매개변수로 전달함.
      return ListTile(    // i값을 전달받아 ListTile 위잿 형태로 변환하여 그것들의 리스트가 반환됨.
        leading: Icon(Icons.notifications_none),
        title: Text('최근 거래일 및 장소'),
      );
    });

    return ListView(
      physics: NeverScrollableScrollPhysics(),    // 이 리스트의 스크롤 동작 금지 - 이걸 안써주면 스크롤 동작이 안되는 현상 발생 -> 스크롤 안에 스크롤을 넣은 경우로 안쪽 스크롤을 막아서 정상 동작되도록 함.
      shrinkWrap: true,     // 이 리스트가 다른 스크롤 객체 안에 있다면 true로 설정해야 함.
      children: items,
    );
  }
}
