import 'dart:collection';

import 'package:dooromi/HeavyEquipment/model/Equipment.dart';
import 'package:intl/intl.dart';

class HeavyEquipmentRes {
  late List<Equipment> equipments;

  static HeavyEquipmentRes fromJson(LinkedHashMap<String, dynamic> response) {
    List<dynamic> body = response['heavyEquipmentDtos'];
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');

    List<Equipment> heavyEquipments = [];
    for (var value in body) {
      heavyEquipments.add(
          new Equipment(
              value['id'],
              value['equipmentType'],
              value['equipmentWeight'].toString() + value['equipmentUnit'],
              dateFormatter.format(DateTime.parse(value['createdAt']))));
    }

    HeavyEquipmentRes res = new HeavyEquipmentRes();
    res.equipments = heavyEquipments;
    return res;
  }
}