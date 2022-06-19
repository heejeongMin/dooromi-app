import 'package:dooromi/Worklog/function/DooroomiAPI.dart';
import 'package:dooromi/Worklog/model/Worklog.dart';
import 'package:dooromi/Worklog/page/HeavyEquipmentPage.dart';
import 'package:flutter/material.dart';

class LocationPage extends StatefulWidget {
  final Worklog worklog;

  LocationPage({required this.worklog});

  @override
  _LocationPageState createState() => new _LocationPageState(worklog: worklog);
}

class _LocationPageState extends State<LocationPage> {

  final Worklog worklog;
  var _location = '';

  _LocationPageState({required this.worklog});

  @override
  void initState() {
    super.initState();
    _location = worklog.location ?? '';
  }


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
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(30)
                  )   ,
                  child:
                  new Text(
                    "근무장소 입력",
                    style: new TextStyle(
                        fontSize:25.0,
                        color: Colors.white,
                        fontFamily: "Roboto"
                    ),
                  ),
                ),
                new Padding(
                  padding: const EdgeInsets.fromLTRB(30, 50, 30, 10),
                  child: new TextFormField(
                      initialValue: '$_location',
                      onChanged: (text){
                        _location = text;
                      },
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: '장소  ex) 쌍문동',
                      ),
                  ),
                ),
                // new Padding(
                //   padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                //   child: Icon(
                //     Icons.mic,
                //     color: Colors.teal,
                //     size: 100
                //   )
                // ),
                new Container(
                    margin: const EdgeInsets.only(top: 16.0),
                    padding: const EdgeInsets.all(5.0),
                    alignment: Alignment.centerRight,
                    child:
                    ElevatedButton(
                      child: Text('다음'),
                      style: ElevatedButton.styleFrom(
                          primary: Colors.indigo),
                      onPressed: () {
                        if(_location.length == 0) {
                          DooroomiAPI.showInputValidationAlert(context);
                        } else {
                          worklog.setLocation(_location);
                          Navigator.of(context).push(
                              MaterialPageRoute(
                                  settings: RouteSettings(name: "/HeavyEquipmentPage"),
                                  builder: (context) => new HeavyEquipmentPage(worklog: worklog)
                              ));
                        }
                      },
                    )
                ),
              ]
          ),
        )
    );
  }
}