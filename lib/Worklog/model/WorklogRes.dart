import 'dart:collection';

import 'package:dooromi/Partner/model/Partner.dart';
import 'package:dooromi/HeavyEquipment/model/Equipment.dart';
import 'package:dooromi/Worklog/model/Worklog.dart';
import 'package:intl/intl.dart';

import 'Worklog.dart';

class WorklogRes {
  late int totalItems;
  late List<Worklog> worklogList;

  static WorklogRes fromJson(LinkedHashMap<String, dynamic> response) {

    List<dynamic> body = response['worklogDtos'];
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');

    if(body == null) {
      WorklogRes res = new WorklogRes();
      res.worklogList = [];
      res.totalItems = 0;
      return res;
    }
    List<Worklog> worklogList = [];

    for (var value in body) {

      String createdAt = value['createdAt'];
      String workDate = value['workDate'];
      String workTime = value['workTime'];

      Worklog worklog =
        new Worklog(
          dateFormatter.format(DateTime.parse(workDate)), workTime);

      worklog.setId(value['id']);
      worklog.setLocation(value['location']);
      worklog.setWorkPay(value['workPay']);
      worklog.setCreatedAt(dateFormatter.format(DateTime.parse(createdAt)));

      worklog.setEquipment(
          new Equipment(
              value['heavyEquipmentDto']['id'],
              value['heavyEquipmentDto']['equipmentType'],
              value['heavyEquipmentDto']['equipmentWeight'].toString()
                  +
                  value['heavyEquipmentDto']['equipmentUnit'],
              value['heavyEquipmentDto']['halfDayAmount'],
              value['heavyEquipmentDto']['fullDayAmount'],
              value['heavyEquipmentDto']['nightShiftAmount'],
              value['heavyEquipmentDto']['createdAt']));


      worklog.setPartner(
          Partner.ofSimple(value['partnerDto']['id'], value['partnerDto']['partnerNumber'],
          value['partnerDto']['companyName']));
      worklogList.add(worklog);
    }

    WorklogRes res = new WorklogRes();
    res.worklogList = worklogList;
    res.totalItems = response['totalItems'];
    return res;
  }
}