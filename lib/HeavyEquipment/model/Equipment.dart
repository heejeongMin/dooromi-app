import 'package:flutter/material.dart';

class Equipment {
  int id;
  String equipment;
  String spec;
  double price;
  String createdAt;

  Equipment(this.id, this.equipment, this.spec, this.price, this.createdAt);

  @override
  String toString() {
    return id.toString() + " " + equipment + " " + spec;
  }

  String nameAndSpec(){
    String equipmentKr = "";
    if(equipment == "CRANE") {
      equipmentKr = "크레인";
    }
    return equipmentKr + " " + spec;
  }

  String equipmentKR(){
    if(equipment == "CRANE") {
      print("return");
      return "크레인";
    }
    return "";
  }
}