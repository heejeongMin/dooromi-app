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

    print("before loop");
    for (var value in body) {
      print("in");
      String startDateAndTime = value['startDate'];
      String endDateAndTime = value['endDate'];

      String startHour = (DateTime.parse(startDateAndTime).hour < 10)
          ? "0" + DateTime.parse(startDateAndTime).hour.toString()
          : DateTime.parse(startDateAndTime).hour.toString();

      String startMinute = (DateTime.parse(startDateAndTime).minute < 10)
          ? "0" + DateTime.parse(startDateAndTime).minute.toString()
          : DateTime.parse(startDateAndTime).minute.toString();

      String endHour = (DateTime.parse(endDateAndTime).hour < 10)
          ? "0" + DateTime.parse(endDateAndTime).hour.toString()
          : DateTime.parse(endDateAndTime).hour.toString();

      String endMinute = (DateTime.parse(endDateAndTime).minute < 10)
          ? "0" + DateTime.parse(endDateAndTime).minute.toString()
          : DateTime.parse(endDateAndTime).minute.toString();

      Worklog worklog =
        new Worklog(
          dateFormatter.format(DateTime.parse(startDateAndTime)),
            startHour + ":" + startMinute, endHour + ":" + endMinute);

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