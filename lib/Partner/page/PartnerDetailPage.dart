import 'package:dooromi/Partner/funciton/PartnerApi.dart';
import 'package:dooromi/Partner/model/Partner.dart';
import 'package:dooromi/Partner/page/PartnerListPage.dart';
import 'package:flutter/material.dart';

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
        title: new Text('두루미'),
      ),
      body:
      new SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(20),
        child:
            new Column(
              children: [
                new Container(
                  width: 150,
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(30)
                  )   ,
                  child:
                  new Text(
                    "거래처 상세",
                    style: new TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontFamily: "Roboto"
                    ),
                  ),
                ),
                new Row(
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
                        padding: const EdgeInsets.fromLTRB(35, 30, 0, 10),
                      ),

                      new Padding(
                        child:
                        new Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              new Padding(
                                child:
                                new Text(
                                  partner.companyName,
                                  style: new TextStyle(fontSize: 23.0,
                                      color: const Color(0xFF000000),
                                      fontWeight: FontWeight.w500,
                                      fontFamily: "Roboto"),
                                ),

                                padding: const EdgeInsets.fromLTRB(18.0, 24.0, 24.0, 0.0),
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

                                padding: const EdgeInsets.fromLTRB(18.0, 10.0, 24.0, 0.0),
                              ),

                              new Padding(
                                child:
                                new Text(
                                  partner.phoneNumber,
                                  style: new TextStyle(fontSize: 15.0,
                                      color: const Color(0xFF000000),
                                      fontWeight: FontWeight.w400,
                                      fontFamily: "Roboto"),
                                ),

                                padding: const EdgeInsets.fromLTRB(18.0, 10.0, 24.0, 0.0),
                              ),


                            ]

                        ),

                        padding: const EdgeInsets.all(24.0),
                      ),
                    ]
                ),
                new Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      new Container(
                          margin: const EdgeInsets.only(top: 30.0),
                          padding: const EdgeInsets.all(5.0),
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            child: Text('삭제'),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text('근무일정 삭제'),
                                      content: SingleChildScrollView(
                                        child: ListBody(
                                          children: [
                                            Text('정말 삭제하시겠습니까?'),
                                          ],
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          child: Text('삭제'),
                                          onPressed: () {
                                            PartnerApi.deletePartner(
                                                partner, context);
                                          },
                                        ),
                                        TextButton(
                                          child: Text('취소'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  });
                            },
                          )),
                      new Container(
                          margin: const EdgeInsets.only(top: 30.0),
                          padding: const EdgeInsets.all(5.0),
                          alignment: Alignment.centerRight,
                          child: ElevatedButton(
                            child: Text('목록'),
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          PartnerListPage()),
                                      (route) => false);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(builder: (context) => new ScheduleListPage(),)
                              // );
                            },
                          )),
                    ]),
                // _buildBottom()
              ],
            )
      )
    );
  }

  // Widget _buildBottom() {
  //   final items = List.generate(10, (i) {     // List.generate() 함수는 0부터 9까지의 수(10개)를 생성하여 두 번째 인수의 함수에 i 매개변수로 전달함.
  //     return ListTile(    // i값을 전달받아 ListTile 위잿 형태로 변환하여 그것들의 리스트가 반환됨.
  //       leading: Icon(Icons.notifications_none),
  //       title: Text('최근 거래일 및 장소'),
  //     );
  //   });
  //
  //   return ListView(
  //     physics: NeverScrollableScrollPhysics(),    // 이 리스트의 스크롤 동작 금지 - 이걸 안써주면 스크롤 동작이 안되는 현상 발생 -> 스크롤 안에 스크롤을 넣은 경우로 안쪽 스크롤을 막아서 정상 동작되도록 함.
  //     shrinkWrap: true,     // 이 리스트가 다른 스크롤 객체 안에 있다면 true로 설정해야 함.
  //     children: items,
  //   );
  // }
}
