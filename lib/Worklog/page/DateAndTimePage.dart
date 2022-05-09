
import 'package:dooromi/Worklog/model/Worklog.dart';
import 'package:flutter/material.dart';

import 'LocationPage.dart';


class DateAndTimePage extends StatefulWidget {
  final Worklog? worklog;

  DateAndTimePage({this.worklog});

  @override
  _DateAndTimePageState createState() => new _DateAndTimePageState(worklog: worklog);
}


class _DateAndTimePageState extends State<DateAndTimePage> {
  final Worklog? worklog;
  var _workDate = '';
  var _workTime = '';
  var _times = ["반나절", "하루", "야간"];
  var _selectedTime = '';

  _DateAndTimePageState({this.worklog});

  @override
  void initState() {
    super.initState();
    if(worklog != null) {
      this._workDate = worklog!.date;
      this._workTime = worklog!.workTime;
    }
  }

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
                      color: Colors.brown,
                      borderRadius: BorderRadius.circular(30)
                  )   ,
                  child:
                  new Text(
                    "근무시간 입력",
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
                                _workDate = dateTime!.toString().substring(0, 11);
                              });
                            });
                          },
                          child: Text('날짜'),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 40),
                        child: Text(
                          '$_workDate',
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
                          onPressed: (){},
                          child: Text('시간'),
                        ),
                      ),
                      DropdownButton(
                          value: _times[0],
                          items: _times.map((value) {
                            return new DropdownMenuItem(
                                value: value, child: Text(value));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              this._selectedTime = value as String;
                              // });
                            });
                          }
                      ),
                      ]
                ),
                new Container(
                    margin: const EdgeInsets.only(top: 70.0),
                    padding: const EdgeInsets.all(5.0),
                    alignment: Alignment.centerRight,
                    child:
                    ElevatedButton(
                        child: Text('다음'),
                        onPressed: () {
                          final Worklog? myWorklog =
                          (worklog == null)? new Worklog(_workDate, _selectedTime) : this.worklog;


                          Navigator.of(context).push(
                              MaterialPageRoute(
                                  settings: RouteSettings(name: "/LocationPage"),
                                  builder: (context) => new LocationPage(worklog: myWorklog!)
                              ));
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(builder: (context) => new LocationPage(worklog: myWorklog!))
                          // );
                          },
                    )
                ),
              ]
          ),
        )
    );
  }
}