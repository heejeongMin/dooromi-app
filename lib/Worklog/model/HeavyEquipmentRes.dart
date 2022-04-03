import 'dart:collection';

import 'package:dooromi/Worklog/model/Equipment.dart';

class HeavyEquipmentRes {
  late List<Equipment> equipments;

  static HeavyEquipmentRes fromJson(LinkedHashMap<String, dynamic> response) {
    List<dynamic> body = response['heavyEquipmentDtos'];

    List<Equipment> heavyEquipments = [];
    for (var value in body) {
      heavyEquipments.add(
          new Equipment(
              value['id'],
              value['equipmentType'],
              value['equipmentWeight'].toString() + value['equipmentUnit']));
    }

    HeavyEquipmentRes res = new HeavyEquipmentRes();
    res.equipments = heavyEquipments;
    return res;
  }
}