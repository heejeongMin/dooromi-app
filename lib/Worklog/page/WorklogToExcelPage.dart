
import 'package:dooromi/Worklog/function/DooroomiAPI.dart';
import 'package:dooromi/Worklog/model/Worklog.dart';
import 'package:flutter/material.dart';

import 'LocationPage.dart';

class WorklogToExcelPage extends StatefulWidget {
  @override
  _WorklogToExcelPageState createState() => new _WorklogToExcelPageState();
}

class _WorklogToExcelPageState extends State<WorklogToExcelPage> {
  var _startDate = '';
  var _endDate= '';
  var email = '';

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('두루미'),
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
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(30)
                  )   ,
                  child:
                  new Text(
                    "엑셀 추출",
                    style: new TextStyle(
                        fontSize:25.0,
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
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40.0, 50.0, 30.0, 10.0),
                        child:  ElevatedButton(
                          onPressed: (){
                            Future<DateTime?> selectedDate = showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2021),
                              lastDate: DateTime(2026),
                            );
                            selectedDate.then((dateTime){
                              setState((){
                                _startDate = dateTime!.toString().substring(0, 11);
                              });
                            });
                          },
                          child: Text('시작일자'),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Text(
                          '$_startDate',
                          style: new TextStyle(
                              fontSize: 12.0,
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.bold,
                              fontFamily: "Roboto"),
                        ),
                      )

                    ]
                ),
                new Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40.0, 5.0, 30.0, 10.0),
                        child:  ElevatedButton(
                          onPressed: (){
                            Future<DateTime?> selectedDate = showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2021),
                              lastDate: DateTime(2026),
                            );
                            selectedDate.then((dateTime){
                              setState((){
                                _endDate = dateTime!.toString().substring(0, 11);
                              });
                            });
                          },
                          child: Text('종료일자'),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Text(
                          '$_endDate',
                          style: new TextStyle(
                              fontSize: 12.0,
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.bold,
                              fontFamily: "Roboto"),
                        ),
                      )

                    ]
                ),
                new Row (
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                        new Padding(
                          padding: const EdgeInsets.fromLTRB(40.0, 5.0, 30.0, 10.0),
                          child:  ElevatedButton(
                            onPressed: (){},
                            child: Text('이메일'),
                          ),
                        ),
                        new Flexible(
                          child: new TextField(
                            decoration: const InputDecoration(helperText: "example123@gmail.com"),
                            style: Theme.of(context).textTheme.body1,
                            onChanged: (text){
                              email = text;
                            },
                          ),
                        ),
                      ]
                ),

                new Container(
                    margin: const EdgeInsets.only(top: 30.0),
                    padding: const EdgeInsets.all(5.0),
                    alignment: Alignment.centerRight,
                    child:
                    ElevatedButton(
                      child: Text('추출'),
                      onPressed: () {

                        print(_startDate);
                        print(_endDate);
                        print(email);

                        DooroomiAPI.sendEmail(_startDate, _endDate, email, context);

                      },
                    )
                ),
              ]
          ),
        )
    );
  }
}