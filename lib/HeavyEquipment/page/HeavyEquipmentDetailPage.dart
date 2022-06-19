import 'dart:ui';

import 'package:dooromi/HeavyEquipment/model/Equipment.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HeavyEquipmentDetailPage extends StatefulWidget {
  final Equipment equipment;

  HeavyEquipmentDetailPage({required this.equipment});

  @override
  _HeavyEquipmentDetailPageState createState() =>
      new _HeavyEquipmentDetailPageState(equipment: equipment);
}

class _HeavyEquipmentDetailPageState extends State<HeavyEquipmentDetailPage> {
  final Equipment equipment;
  final NumberFormat numberFormat = NumberFormat.decimalPattern('en_us');

  _HeavyEquipmentDetailPageState({required this.equipment});

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('두루미'),
        ),
        body: new SingleChildScrollView(
            scrollDirection: Axis.vertical,
            padding: const EdgeInsets.all(20),
            child: new Column(
              children: [
                new Container(
                  width: 150,
                  height: 45,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(30)),
                  child: new Text(
                    "장비 상세",
                    style: new TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                        fontFamily: "Roboto"),
                  ),
                ),
                new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new Container(
                      width: 100,
                      child: new Padding(
                        padding: const EdgeInsets.fromLTRB(30, 40, 30, 0),
                        child: Text('장비'),
                      ),
                    ),
                    new Padding(
                      child: new Text(
                        equipment.equipment,
                        style: new TextStyle(
                            fontSize: 18.0,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w500,
                            fontFamily: "Roboto"),
                      ),
                      padding: const EdgeInsets.fromLTRB(20.0, 35.0, 0.0, 0.0),
                    ),
                  ],
                ),
                new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new Container(
                      width: 100,
                      child: new Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 30, 5),
                        child: Text('규격'),
                      ),
                    ),
                    new Padding(
                      child: new Text(
                        equipment.spec,
                        style: new TextStyle(
                            fontSize: 18.0,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Roboto"),
                      ),
                      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                    ),
                  ],
                ),
                new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new Container(
                      width: 100,
                      child: new Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 10, 5),
                        child: Text('반일 금액'),
                      ),
                    ),
                    new Padding(
                      child: new Text(
                        numberFormat.format(equipment.halfDayAmount) + " 원",
                        style: new TextStyle(
                            fontSize: 16.0,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Roboto"),
                      ),
                      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 24.0, 0.0),
                    ),
                  ],
                ),
                new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new Container(
                      width: 100,
                      child: new Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 10, 5),
                        child: Text('하루 금액'),
                      ),
                    ),
                    new Padding(
                      child: new Text(
                        numberFormat.format(equipment.fullDayAmount) + " 원",
                        style: new TextStyle(
                            fontSize: 16.0,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Roboto"),
                      ),
                      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 24.0, 0.0),
                    ),
                  ],
                ),
                new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new Container(
                      width: 100,
                      child: new Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 10, 5),
                        child: Text('야간 금액'),
                      ),
                    ),
                    new Padding(
                      child: new Text(
                        numberFormat.format(equipment.nightShiftAmount) + " 원",
                        style: new TextStyle(
                            fontSize: 16.0,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Roboto"),
                      ),
                      padding: const EdgeInsets.fromLTRB(20.0, 10.0, 24.0, 0.0),
                    ),
                  ],
                ),
                new Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    new Container(
                      width: 100,
                      child: new Padding(
                        padding: const EdgeInsets.fromLTRB(30, 20, 10, 5),
                        child: Text('생성일'),
                      ),
                    ),
                    new Padding(
                      child: new Text(
                        equipment.createdAt,
                        style: new TextStyle(
                            fontSize: 16.0,
                            color: const Color(0xFF000000),
                            fontWeight: FontWeight.w400,
                            fontFamily: "Roboto"),
                      ),
                      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0.0, 0.0),
                    ),
                  ],
                ),
              ],
            )));
  }
}
