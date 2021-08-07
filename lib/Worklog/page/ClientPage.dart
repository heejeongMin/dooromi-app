import 'package:dooromi/Worklog/model/Worklog.dart';

import 'package:dooromi/Worklog/page/HeavyEquipmentPage.dart';
import 'package:flutter/material.dart';

class ClientPage extends StatefulWidget {
  final Worklog worklog;

  ClientPage({required this.worklog});

  @override
  _ClientPageState createState() => new _ClientPageState(worklog: worklog);
}

class _ClientPageState extends State<ClientPage> {

  final Worklog worklog;

  _ClientPageState({required this.worklog});

  @override
  Widget build(BuildContext context) {
    var _location = '';

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
                      color: Colors.teal,
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
                  child: new TextField(
                    onChanged: (text){
                      print(text);
                      _location = text;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: '장소  ex) 쌍문동'
                    ),
                  ),
                ),
                new Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                    child: Icon(
                        Icons.mic,
                        color: Colors.teal,
                        size: 100
                    )
                ),
                new Container(
                    margin: const EdgeInsets.only(top: 16.0),
                    padding: const EdgeInsets.all(5.0),
                    alignment: Alignment.centerRight,
                    child:
                    ElevatedButton(
                      child: Text('다음'),
                      onPressed: () {
                        worklog.setLocation(_location);
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => new HeavyEquipmentPage(worklog: worklog))
                        );
                      },
                    )
                ),
              ]
          ),
        )
    );
  }
}