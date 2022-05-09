import 'package:dooromi/Worklog/function/DooroomiAPI.dart';
import 'package:dooromi/Worklog/model/Worklog.dart';
import 'package:dooromi/Worklog/page/ScheduleListPage.dart';

import 'package:flutter/material.dart';

class WorklogDetailPage extends StatefulWidget {
  final Worklog worklog;


  WorklogDetailPage({required this.worklog});

  @override
  _WorklogDetailPageState createState() => new _WorklogDetailPageState(worklog: worklog);
}

class _WorklogDetailPageState extends State<WorklogDetailPage> {

  final Worklog worklog;

  _WorklogDetailPageState({required this.worklog});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          title: Text('두루미'),
        ),
        body:
        new SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(40),
          child:
          new Column(
              children: <Widget>[
                new Container(
                  width: 250,
                  height: 60,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(30)
                  )   ,
                  child:
                  new Text(
                    "근무일정 상세",
                    style: new TextStyle(
                        fontSize:25.0,
                        color: Colors.white,
                        fontFamily: "Roboto"
                    ),
                  ),
                ),
                new Row(
                    mainAxisSize : MainAxisSize.max,
                    mainAxisAlignment : MainAxisAlignment.start,
                    crossAxisAlignment : CrossAxisAlignment.center,
                    children: [
                      new Padding(
                        padding: const EdgeInsets.fromLTRB(30, 50, 55, 10),
                        child:Text('일자'),
                      ),
                      new Padding(
                        padding: const EdgeInsets.fromLTRB(30, 50, 30, 10),
                        child:Text(worklog.date),
                      ),
                    ]
                ),
                new Row(
                    mainAxisSize : MainAxisSize.max,
                    mainAxisAlignment : MainAxisAlignment.start,
                    crossAxisAlignment : CrossAxisAlignment.center,
                    children: [
                      new Padding(
                        padding: const EdgeInsets.fromLTRB(30, 10, 55, 10),
                        child:Text('시작'),
                      ),
                      new Padding(
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child:Text(worklog.workTime),
                      ),
                    ]
                ),
                new Row(
                    mainAxisSize : MainAxisSize.max,
                    mainAxisAlignment : MainAxisAlignment.start,
                    crossAxisAlignment : CrossAxisAlignment.center,
                    children: [
                      new Padding(
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child:Text('근무장소'),
                      ),
                      new Padding(
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child:Text(worklog.location!),
                      ),
                    ]
                ),
                new Row(
                    mainAxisSize : MainAxisSize.max,
                    mainAxisAlignment : MainAxisAlignment.start,
                    crossAxisAlignment : CrossAxisAlignment.center,
                    children: [
                      new Padding(
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child:Text('근무장비'),
                      ),
                      new Padding(
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child:Text(worklog.equipment!.nameAndSpec()),
                      ),
                    ]
                ),
                new Row(
                    mainAxisSize : MainAxisSize.max,
                    mainAxisAlignment : MainAxisAlignment.start,
                    crossAxisAlignment : CrossAxisAlignment.center,
                    children: [
                      new Padding(
                        padding: const EdgeInsets.fromLTRB(30, 10, 40, 10),
                        child:Text('거래처'),
                      ),
                      new Padding(
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child:Text(worklog.partner!.companyName),
                      ),
                    ]
                ),
                new Row(
                    mainAxisSize : MainAxisSize.max,
                    mainAxisAlignment : MainAxisAlignment.spaceAround,
                    crossAxisAlignment : CrossAxisAlignment.center,
                    children: [
                      new Container(
                          margin: const EdgeInsets.only(top: 16.0),
                          padding: const EdgeInsets.all(5.0),
                          alignment: Alignment.centerRight,
                          child:
                          ElevatedButton(
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
                                          onPressed: (){
                                            DooroomiAPI.deleteWorklog(worklog, context);
                                          },
                                        ),
                                        TextButton(
                                          child: Text('취소'),
                                          onPressed: (){
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  }
                              );
                            },
                          )
                      ),
                      new Container(
                          margin: const EdgeInsets.only(top: 16.0),
                          padding: const EdgeInsets.all(5.0),
                          alignment: Alignment.centerRight,
                          child:
                          ElevatedButton(
                            child: Text('목록'),
                            onPressed: () {

                              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      ScheduleListPage(partnerName: "")), (route) => false);
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(builder: (context) => new ScheduleListPage(),)
                              // );
                            },
                          )
                      ),
                    ]
                ),

              ]
          ),
        )
    );
  }


  deleteWorklog(worklog){
    String message = (true)? "성공적으로 삭제되었습니다." : "삭제에 실패하였습니다.";


    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(''),
            content: SingleChildScrollView(
              child: ListBody(
                children: [
                  Text(message),
                ],
              ),
            ),
            actions: [
              TextButton(
                child: Text('OK'),
                onPressed: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (BuildContext context) => ScheduleListPage(partnerName: ""),
                      ), (Route<dynamic> route) => false);
                },
              ),
            ],
          );
        }
    );
  }

}