import 'package:flutter/material.dart';

void main() {
  runApp(new MyApp());
}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Generated App',
      theme: new ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: new MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => new _MyHomePageState();
}


class _MyHomePageState extends State<MyHomePage> {
  var _workDate = '';
  var _startTime = '';
  var _endTime= '';

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
            // mainAxisAlignment: MainAxisAlignment.center,
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
                        padding: const EdgeInsets.fromLTRB(40.0, 30.0, 30.0, 10.0),
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
                        padding: const EdgeInsets.only(top: 20),
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
                          onPressed: (){
                            Future<TimeOfDay?> selectedTime = showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now()
                            );

                            selectedTime.then((timeOfDay){
                              setState((){
                                _startTime = '${timeOfDay!.hour}:${timeOfDay.minute}';
                              });
                            });
                          },
                          child: Text('시작'),
                        ),
                      ),
                      Text(
                          '$_startTime',
                           style: new TextStyle(
                              fontSize: 22.0,
                              color: const Color(0xFF000000),
                              fontWeight: FontWeight.bold,
                              fontFamily: "Roboto"),
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
                            Future<TimeOfDay?> selectedTime = showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now()
                            );

                            selectedTime.then((timeOfDay){
                              setState((){
                                _endTime = '${timeOfDay!.hour}:${timeOfDay.minute}';
                              });
                            });
                          },
                          child: Text('종료'),
                        ),
                      ),
                      Text(
                        '$_endTime',
                        style: new TextStyle(
                            fontSize: 22.0,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.bold,
                            fontFamily: "Roboto"),
                      )
                    ]
                ),
                new Container(
                    margin: const EdgeInsets.only(top: 16.0),
                    padding: const EdgeInsets.all(5.0),
                    alignment: Alignment.centerRight,
                    child:
                    ElevatedButton(
                        onPressed: () {
                        },
                        child: Text('다음')
                    )
                  // new Text(
                  //   "다음 >",
                  //   style: new TextStyle(
                  //       fontSize:25.0,
                  //       color: Colors.white,
                  //       fontFamily: "Roboto"
                  //   ),
                  // ),
                ),
              ]
          ),
        )





    );
  }
}