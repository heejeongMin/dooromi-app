import 'package:flutter/material.dart';

class Equipment {
  int id;
  String equipment;
  String spec;

  Equipment(this.id, this.equipment, this.spec);


  @override
  String toString() {
    return id.toString() + " " + equipment + " " + spec;
  }
}