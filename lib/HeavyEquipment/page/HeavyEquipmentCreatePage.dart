import 'package:dooromi/HeavyEquipment/function/HeavyEquipmentAPI.dart';
import 'package:dooromi/HeavyEquipment/model/HeavyEquipmentCreateReq.dart';
import 'package:dooromi/Partner/funciton/PartnerApi.dart';
import 'package:dooromi/Partner/model/Partner.dart';
import 'package:flutter/material.dart';

class HeavyEquipmentCreatePage extends StatefulWidget {

  @override
  _HeavyEquipmentCreatePageState createState() =>
      new _HeavyEquipmentCreatePageState();
}

class _HeavyEquipmentCreatePageState extends State<HeavyEquipmentCreatePage> {
  var _equipments = ["크레인"];
  var _selectedEquipment = "크레인";
  var _specs = ["25", "50", "100", "150"];
  var _selectedSpec = "25";
  var _unit =  ["TON"];
  var _selectedUnit = "TON";


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('장비 등록'),
        ),
        body:
        new SingleChildScrollView(
          scrollDirection: Axis.vertical,
          padding: const EdgeInsets.all(40),
          child:
          new Container(
            child:
            new Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
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
                                value: _selectedEquipment,
                                items: _equipments.map((value) {
                                  return new DropdownMenuItem(
                                      value: value, child: Text(value));
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    this._selectedEquipment = value as String;
                                    // });
                                  });
                                }
                          ),
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
                            onChanged: (value) {
                              setState(() {
                                this._selectedSpec = value as String;
                                // });
                              });
                            }
                        ),
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
                        child: Text('단위'),
                      ),
                      new Padding(
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                        child: DropdownButton(
                            value: _selectedUnit,
                            items: _unit.map((value) {
                              return new DropdownMenuItem(
                                  value: value, child: Text(value));
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                this._selectedUnit = value as String;
                                // });
                              });
                            }
                        ),
                      ),
                    ],
                  ),
                  new Container(
                      margin: const EdgeInsets.only(top: 16.0),
                      padding: const EdgeInsets.all(5.0),
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        child: Text('저장'),
                        onPressed: () {

                          var equipmentType = "CRANE";
                          if(_selectedEquipment == "크레인") {
                            equipmentType = "CRANE";
                          }

                          // Navigator.of(context, rootNavigator: true).pop();
                          HeavyEquipmentAPI.createHeavyEquipment(
                            new HeavyEquipmentCreateReq(
                                equipmentType,
                                _selectedSpec,
                                _selectedUnit),
                            context
                          );

                        },
                      )),
              ]
            ),
          )
       )
    );
  }
}