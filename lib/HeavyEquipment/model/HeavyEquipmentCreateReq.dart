import 'dart:collection';

import 'package:dooromi/HeavyEquipment/model/Equipment.dart';

class HeavyEquipmentCreateReq {
  String equipmentType;
  String equipmentUnit;
  String equipmentWeight;

  HeavyEquipmentCreateReq(this.equipmentType, this.equipmentWeight, this.equipmentUnit);

  @override
  String toString() {
    return equipmentType + " " + equipmentUnit + " " + equipmentWeight;
  }

  Map<String, dynamic> toJson() => {
  "equipmentType" : this.equipmentType,
  "equipmentWeight" : this.equipmentWeight,
    "equipmentUnit" : this.equipmentUnit
  };

}