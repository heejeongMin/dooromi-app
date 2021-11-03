import 'package:dooromi/Worklog/model/Equipment.dart';
import 'package:dooromi/Worklog/model/Worklog.dart';
import 'package:dooromi/Worklog/page/ClientPage.dart';
import 'package:flutter/material.dart';

class HeavyEquipmentPage extends StatefulWidget {
  final Worklog worklog;

  HeavyEquipmentPage({required this.worklog});

  @override
  _HeavyEquipmentState createState() => new _HeavyEquipmentState(worklog: worklog);
}

class _HeavyEquipmentState extends State<HeavyEquipmentPage> {

  final Worklog worklog;
  final _equipmentList = ['크레인', '굴삭기', '포크레인']; //todo 서버에서 리스트 받아오기
  final _sepcList = ['25T', '50T', '100T'];
  var _selectedEquipment = '크레인';
  var _selectedSpec = '25T';


  _HeavyEquipmentState({required this.worklog});

  @override
  void initState() {
    super.initState();
    if(worklog.equipment != null) {
      switch(worklog.equipment!.equipment) {
        case "CRANE" :  _selectedEquipment = "크레인"; break;
      }
      if(worklog.equipment!.spec.contains("TON")) {
        _selectedSpec = worklog.equipment!.spec.substring(0, worklog.equipment!.spec.indexOf("TON")) + "T";
      }
    }
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
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(30)
                  )   ,
                  child:
                  new Text(
                     "근무장비 입력",
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
                     padding: const EdgeInsets.fromLTRB(30, 50, 30, 10),
                     child:Text('장비'),
                   ),
                   new Padding(
                     padding: const EdgeInsets.fromLTRB(30, 50, 30, 10),
                     child: DropdownButton(
                         value: this._selectedEquipment,
                         items: _equipmentList.map((value) {
                           print(123);
                           return new DropdownMenuItem(

                               value: value,
                               child: Text(value)
                           );
                         }
                         ).toList(),

                         onChanged: (value){
                           setState(() {
                             this._selectedEquipment = value as String;
                             print(_selectedEquipment);

                           });
                         }
                     ),
                   ),
                 ],
               ),
          new Row(
              mainAxisSize : MainAxisSize.max,
              mainAxisAlignment : MainAxisAlignment.start,
              crossAxisAlignment : CrossAxisAlignment.center,
              children: [
                new Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child:Text('규격'),
                ),
                new Padding(
                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                  child: DropdownButton(
                      value: _selectedSpec,
                      items: _sepcList.map((value) {
                        return DropdownMenuItem(
                            value: value,
                            child: Text(value)
                        );
                      }
                      ).toList(),
                      onChanged: (value){
                        setState(() {
                          _selectedSpec = value as String;
                        });
                      }
                  ),
                ),
              ]
          ),
                new Container(
                    margin: const EdgeInsets.only(top: 16.0),
                    padding: const EdgeInsets.all(5.0),
                    alignment: Alignment.centerRight,
                    child:
                    ElevatedButton(
                      child: Text('다음'),
                      onPressed: () {
                        worklog.setEquipment(new Equipment(1, _selectedEquipment, _selectedSpec));
                        Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => new ClientPage(worklog: worklog))
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