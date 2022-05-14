import 'package:flutter/material.dart';

class Equipment {
  int id;
  String equipment;
  String spec;
  double halfDayAmount;
  double fullDayAmount;
  double nightShiftAmount;
  String createdAt;

  Equipment(this.id, this.equipment, this.spec, this.halfDayAmount,
      this.fullDayAmount, this.nightShiftAmount, this.createdAt);

  @override
  String toString() {
    return id.toString() + " " + equipment + " " + spec;
  }

  String nameAndSpec() {
    String equipmentKr = "";
    if (equipment == "CRANE") {
      equipmentKr = "크레인";
    }
    return equipmentKr + " " + spec;
  }

  String equipmentKR() {
    if (equipment == "CRANE") {
      print("return");
      return "크레인";
    }
    return "";
  }
}
