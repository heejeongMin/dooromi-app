import 'dart:collection';

import 'package:dooromi/HeavyEquipment/model/Equipment.dart';

class HeavyEquipmentCreateReq {
  String equipmentType;
  String equipmentUnit;
  String equipmentWeight;
  int halfDayAmount;
  int fullDayAmount;
  int nightShiftAmount;

  HeavyEquipmentCreateReq(
      this.equipmentType,
      this.equipmentWeight,
      this.equipmentUnit,
      this.halfDayAmount,
      this.fullDayAmount,
      this.nightShiftAmount);

  @override
  String toString() {
    return equipmentType + " " + equipmentUnit + " " + equipmentWeight;
  }

  Map<String, dynamic> toJson() => {
    "equipmentType" : this.equipmentType,
    "equipmentWeight" : this.equipmentWeight,
    "equipmentUnit" : this.equipmentUnit,
    "equipmentPrice" : {
      "halfDayAmount" : this.halfDayAmount,
      "fullDayAmount" : this.fullDayAmount,
      "nightShiftAmount" : this.nightShiftAmount
    }
  };
}