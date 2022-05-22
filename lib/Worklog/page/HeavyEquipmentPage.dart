import 'dart:collection';

import 'package:dooromi/HeavyEquipment/function/HeavyEquipmentAPI.dart';
import 'package:dooromi/HeavyEquipment/model/Equipment.dart';
import 'package:dooromi/HeavyEquipment/model/HeavyEquipmentRes.dart';
import 'package:dooromi/Worklog/model/Worklog.dart';
import 'package:dooromi/Worklog/page/ClientPage.dart';
import 'package:flutter/material.dart';

class HeavyEquipmentPage extends StatefulWidget {
  final Worklog worklog;

  HeavyEquipmentPage({required this.worklog});

  @override
  _HeavyEquipmentState createState() =>
      new _HeavyEquipmentState(worklog: worklog);
}

class _HeavyEquipmentState extends State<HeavyEquipmentPage> {
  final Future<HeavyEquipmentRes> heavyEquipments =
      HeavyEquipmentAPI.getAllHeavyEquipment();
  final Worklog worklog;
  var _equipments = HashSet<String>();
  var _specs = [];
  var _selectedEquipment = '크레인';
  var _selectedSpec = '';
  var apiResult;
  double _workPay = 0;
  var _workPayController = TextEditingController();

  _HeavyEquipmentState({required this.worklog});

  @override
  void initState() {
    super.initState();
    if (worklog.equipment != null) {
      switch (worklog.equipment!.equipment) {
        case "CRANE":
          _selectedEquipment = "크레인";
          break;
      }
      if (worklog.equipment!.spec.contains("TON")) {
        _selectedSpec = worklog.equipment!.spec
                .substring(0, worklog.equipment!.spec.indexOf("TON")) +
            "T";
      }
    }

  }

  void syncData(heavyEquipmentRes) {
    _equipments = HashSet<String>();
    _specs = [];
    apiResult = heavyEquipmentRes.equipments;
    heavyEquipmentRes.equipments.forEach((element) {
      String specString = element.spec.toString();
      if (element.equipment == 'CRANE') {
        _equipments.add("크레인");
        if(!(_specs.contains(specString))) {
          _specs.add(specString);
        }
      }
    });

    if(_selectedSpec == '') {
      _selectedSpec = _specs[0];
    }

    Equipment equipment = findEquipment();
    print(worklog.workTime);
    if(worklog.workTime == 'DAY') {
      _workPayController.text =
          equipment.fullDayAmount.toInt().toString();
      _workPay = equipment.fullDayAmount;
    } else if(worklog.workTime == 'NIGHT') {
      _workPayController.text =
          equipment.nightShiftAmount.toInt().toString();
      _workPay = equipment.nightShiftAmount;
    } else {
      _workPayController.text =
          equipment.halfDayAmount.toInt().toString();
      _workPay = equipment.halfDayAmount;
    }
  }

  Equipment findEquipment(){
    Equipment equipment = new Equipment(0, "", "", 0.0, 0.0, 0.0, "");
    apiResult.forEach((element) {
      if (element.spec == _selectedSpec) {
        equipment = element;
      }
    });
    return equipment;
  }

  @override
  Widget build(BuildContext context) {
    print(_specs);
    return DefaultTextStyle(
      style: Theme.of(context).textTheme.headline2!,
      textAlign: TextAlign.center,
      child: FutureBuilder<HeavyEquipmentRes>(
        future: heavyEquipments, // a previously-obtained Future<String> or null
        builder:
            (BuildContext context, AsyncSnapshot<HeavyEquipmentRes> snapshot) {
          List<Widget> children;
          if (snapshot.hasData) {
            syncData(snapshot.requireData);

            children = <Widget>[
              new Container(
                width: 250,
                height: 60,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.brown,
                    borderRadius: BorderRadius.circular(30)),
                child: new Text(
                  "근무장비 입력",
                  style: new TextStyle(
                      fontSize: 25.0,
                      color: Colors.white,
                      fontFamily: "Roboto"),
                ),
              ),
              // _equipments,
              new Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  new Padding(
                    padding: const EdgeInsets.fromLTRB(30, 50, 30, 10),
                    child: Text('장비'),
                  ),
                  new Padding(
                    padding: const EdgeInsets.fromLTRB(30, 50, 30, 10),
                    child: DropdownButton(
                        value: this._selectedEquipment,
                        items: _equipments.map((value) {
                          return new DropdownMenuItem(
                              value: value, child: Text(value));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            this._selectedEquipment = value as String;

                          });
                        }),
                  ),
                ],
              ),
              new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: Text('규격'),
                    ),
                    new Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: DropdownButton(
                          value: _selectedSpec,
                          items: _specs.map((value) {
                            return new DropdownMenuItem(
                                value: value, child: Text(value));
                          }).toList(),
                          onChanged: (value){
                            setState(() {
                              this._selectedSpec = value as String;

                              Equipment equipment = findEquipment();
                              print(worklog.workTime);
                              if(worklog.workTime == 'DAY') {
                                _workPayController.text =
                                    equipment.fullDayAmount.toInt().toString();
                                _workPay = equipment.fullDayAmount;
                              } else if(worklog.workTime == 'NIGHT') {
                                _workPayController.text =
                                    equipment.nightShiftAmount.toInt().toString();
                                _workPay = equipment.nightShiftAmount;
                              } else {
                                _workPayController.text =
                                    equipment.halfDayAmount.toInt().toString();
                                _workPay = equipment.halfDayAmount;
                              }
                            });
                          }
                      ),
                    ),
                  ]),
              new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: Text('금액'),
                    ),
                    new Container(
                      width: 130,
                      height: 60,
                      padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                      child: new TextFormField(
                        controller: _workPayController,
                        onChanged: (amount) {
                          RegExp regex = new RegExp(r'([0-9]$)');
                          if (!regex.hasMatch(amount)) {
                            _workPayController.text = "0";
                          }
                          _workPay =
                              double.parse(amount.replaceAll("[^\\d.]", ""));
                        },
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                          // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 4.0, horizontal: 10.0),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ]),
              new Container(
                  margin: const EdgeInsets.only(top: 16.0),
                  padding: const EdgeInsets.all(5.0),
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    child: Text('다음'),
                    onPressed: () {
                      worklog.setEquipment(findEquipment());
                      worklog.setWorkPay(_workPay);

                      Navigator.of(context).push(MaterialPageRoute(
                          settings: RouteSettings(name: "/ClientPage"),
                          builder: (context) =>
                              new ClientPage(worklog: worklog)));

                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(builder: (context) => new ClientPage(worklog: worklog))
                      // );
                    },
                  )),
            ];
          } else if (snapshot.hasError) {
            children = <Widget>[
              const Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 60,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text('Error: ${snapshot.error}'),
              )
            ];
          } else {
            children = const <Widget>[
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Text('Awaiting result...'),
              )
            ];
          }
          return Scaffold(
              appBar: AppBar(
                title: Text('두루미'),
              ),
              body: new SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.all(40),
                  child: new Column(
                    children: children,
                  )));
        },
      ),
    );
  }
}