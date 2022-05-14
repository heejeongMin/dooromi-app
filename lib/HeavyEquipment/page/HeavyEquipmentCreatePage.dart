import 'package:dooromi/HeavyEquipment/function/HeavyEquipmentAPI.dart';
import 'package:dooromi/HeavyEquipment/model/HeavyEquipmentCreateReq.dart';
import 'package:flutter/material.dart';

class HeavyEquipmentCreatePage extends StatefulWidget {
  @override
  _HeavyEquipmentCreatePageState createState() =>
      new _HeavyEquipmentCreatePageState();
}

class _HeavyEquipmentCreatePageState extends State<HeavyEquipmentCreatePage> {
  var _equipments = ["크레인"];
  var _selectedEquipment = "크레인";
  var _specs = ["13", "16", "25", "50", "60", "70", "100"];
  var _selectedSpec = "25";
  var _unit = ["TON"];
  var _selectedUnit = "TON";
  var _halfDayAmount = 0;
  var _halfDayAmountController = TextEditingController();
  var _fullDayAmount = 0;
  var _fullDayAmountController = TextEditingController();
  var _nightShiftAmount = 0;
  var _nightShiftAmountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('장비 등록'),
        ),
        body: new SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(40),
            child: new Container(
              child: new Column(
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
                          padding: const EdgeInsets.fromLTRB(30, 20, 30, 5),
                          child: Text('장비'),
                        ),
                        new Padding(
                          padding: const EdgeInsets.fromLTRB(30, 20, 30, 5),
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
                          padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                          child: Text('규격'),
                        ),
                        new Padding(
                          padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
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
                          padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
                          child: Text('단위'),
                        ),
                        new Padding(
                          padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
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
                          padding: const EdgeInsets.fromLTRB(30, 10, 30, 5),
                          child: Text('가격'),
                        ),
                      ],
                    ),
                    new Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new Padding(
                          padding: const EdgeInsets.fromLTRB(50, 10, 10, 5),
                          child: Text('반일'),
                        ),
                        new Container(
                          width: 130,
                          height: 60,
                          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
                          child: new TextFormField(
                            controller: _halfDayAmountController,
                            onChanged: (amount) {
                              RegExp regex = new RegExp(r'([0-9]$)');
                              if (!regex.hasMatch(amount)) {
                                _halfDayAmountController.text = "0";
                              }
                              _halfDayAmount =
                                  int.parse(amount.replaceAll("[^\\d.]", ""));
                            },
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                              // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 10.0),
                              border: OutlineInputBorder(),
                              hintText: '0',
                            ),
                          ),
                        ),
                        new Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 5),
                          child: Text('원'),
                        ),
                      ],
                    ),
                    new Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new Padding(
                          padding: const EdgeInsets.fromLTRB(50, 0, 10, 5),
                          child: Text('하루'),
                        ),
                        new Container(
                          width: 130,
                          height: 40,
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: new TextFormField(
                            controller: _fullDayAmountController,
                            onChanged: (amount) {
                              RegExp regex = new RegExp(r'([0-9]$)');
                              if (!regex.hasMatch(amount)) {
                                _fullDayAmountController.text = "0";
                              }

                              _fullDayAmount =
                                  int.parse(amount.replaceAll("[^\\d.]", ""));
                            },
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                              // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 10.0),
                              border: OutlineInputBorder(),
                              hintText: '0',
                            ),
                          ),
                        ),
                        new Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Text('원'),
                        ),
                      ],
                    ),
                    new Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        new Padding(
                          padding: const EdgeInsets.fromLTRB(50, 0, 10, 5),
                          child: Text('야간'),
                        ),
                        new Container(
                          width: 130,
                          height: 40,
                          padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                          child: new TextFormField(
                            controller: _nightShiftAmountController,
                            onChanged: (amount) {
                              RegExp regex = new RegExp(r'([0-9]$)');
                              if (!regex.hasMatch(amount)) {
                                _nightShiftAmountController.text = "0";
                              }
                              _nightShiftAmount =
                                  int.parse(amount.replaceAll("[^\\d.]", ""));
                            },
                            textAlign: TextAlign.right,
                            decoration: InputDecoration(
                              // border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 4.0, horizontal: 10.0),
                              border: OutlineInputBorder(),
                              hintText: '0',
                            ),
                          ),
                        ),
                        new Padding(
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                          child: Text('원'),
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
                            if (_selectedEquipment == "크레인") {
                              equipmentType = "CRANE";
                            }

                            Navigator.of(context, rootNavigator: true).pop();
                            HeavyEquipmentAPI.createHeavyEquipment(
                                new HeavyEquipmentCreateReq(
                                    equipmentType,
                                    _selectedSpec,
                                    _selectedUnit,
                                    _halfDayAmount,
                                    _fullDayAmount,
                                    _nightShiftAmount),
                                context);
                          },
                        )),
                  ]),
            )));
  }
}
