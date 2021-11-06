import 'dart:collection';

import 'package:dooromi/Worklog/model/Equipment.dart';
import 'package:dooromi/Worklog/model/Worklog.dart';
import 'package:intl/intl.dart';

import 'Worklog.dart';

class WorklogRes {
  late int totalItems;
  late List<Worklog> worklogList;

  static WorklogRes fromJson(LinkedHashMap<String, dynamic> response) {

    List<dynamic> body = response['worklogDtoList'];
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
    final DateFormat timeFormatter = DateFormat('H:m');

    List<Worklog> worklogList = [];

    for (var value in body) {
      String startDateAndTime = value['startDate'];
      String endDateAndTime = value['endDate'];

      Worklog worklog =
        new Worklog(
          dateFormatter.format(DateTime.parse(startDateAndTime)),
          timeFormatter.format(DateTime.parse(startDateAndTime)),
          timeFormatter.format(DateTime.parse(endDateAndTime)));

      worklog.setWorklogNumber(value['id']);
      worklog.setLocation(value['workLocationDto']['gu'] + " "
          + value['workLocationDto']['dong']);

      worklog.setEquipment(
          new Equipment(
              1,
              "",
              ""));
          // new Equipment(
          //     1,
          //     value['heavyEquipmentDto']['equipmentType'],
          //     value['heavyEquipmentDto']['weight'].toString()
          //         +
          //         value['heavyEquipmentDto']['equipmentUnit']));

      worklogList.add(worklog);
    }

    WorklogRes res = new WorklogRes();
    res.worklogList = worklogList;
    res.totalItems = response['totalItems'];
    return res;
  }
}