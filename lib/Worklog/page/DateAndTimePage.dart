import 'package:dooromi/Worklog/function/DooroomiAPI.dart';
import 'package:dooromi/Worklog/model/Worklog.dart';
import 'package:flutter/material.dart';

import 'LocationPage.dart';

class DateAndTimePage extends StatefulWidget {
  final Worklog? worklog;

  DateAndTimePage({this.worklog});

  @override
  _DateAndTimePageState createState() =>
      new _DateAndTimePageState(worklog: worklog);
}

class _DateAndTimePageState extends State<DateAndTimePage> {
  final Worklog? worklog;
  var _workDate = '';
  var _workTime = '';
  var _times = ["반나절", "하루", "야간"];
  var _selectedTime = '반나절';

  _DateAndTimePageState({this.worklog});

  @override
  void initState() {
    super.initState();
    if (worklog != null) {
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
        body: new SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(40),
          child: new Column(children: <Widget>[
            new Container(
              width: 250,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.indigo, borderRadius: BorderRadius.circular(30)),
              child: new Text(
                "근무시간 입력",
                style: new TextStyle(
                    fontSize: 25.0, color: Colors.white, fontFamily: "Roboto"),
              ),
            ),
            new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40.0, 50.0, 30.0, 10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.indigo),
                      onPressed: () {
                        Future<DateTime?> selectedDate = showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2021),
                          lastDate: DateTime(2026),
                            builder: (context, child) {
                              return Theme(
                                data: Theme.of(context).copyWith(
                                  colorScheme: ColorScheme.light(
                                    primary: Colors.indigo, // header background color
                                    onPrimary: Colors.white, // header text color
                                    onSurface: Colors.black, // body text color
                                  ),
                                  textButtonTheme: TextButtonThemeData(
                                    style: TextButton.styleFrom(
                                      primary: Colors.indigo, // button text color
                                    ),
                                  ),
                                ),
                                child: child!,
                              );
                            }
                        );
                        selectedDate.then((dateTime) {
                          setState(() {
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
                ]),
            new Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(40.0, 5.0, 30.0, 10.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.indigo),
                      onPressed: () {},
                      child: Text('시간'),
                    ),
                  ),
                  DropdownButton(
                      value: _selectedTime,
                      items: _times.map((value) {
                        return new DropdownMenuItem(
                            value: value, child: Text(value));
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          this._selectedTime = value as String;
                        });
                      }),
                ]),
            new Container(
                margin: const EdgeInsets.only(top: 70.0),
                padding: const EdgeInsets.all(5.0),
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  child: Text('다음'),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.indigo),
                  onPressed: () {

                    if (_workDate.length == 0) {
                      DooroomiAPI.showInputValidationAlert(context);
                    } else {
                      String workTime = '';
                      if (_selectedTime == '하루') {
                        workTime = 'DAY';
                      } else if (_selectedTime == '야간') {
                        workTime = 'NIGHT';
                      } else {
                        workTime = 'HALFDAY';
                      }
                      final Worklog? myWorklog = (worklog == null)
                          ? new Worklog(_workDate, workTime)
                          : this.worklog;

                      Navigator.of(context).push(MaterialPageRoute(
                          settings: RouteSettings(name: "/LocationPage"),
                          builder: (context) =>
                          new LocationPage(worklog: myWorklog!)));
                    }

                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(builder: (context) => new LocationPage(worklog: myWorklog!))
                    // );
                  },
                )),
          ]),
        ));
  }
}
