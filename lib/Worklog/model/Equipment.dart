import 'package:flutter/material.dart';

class Equipment {
  String equipment;
  String spec;

  Equipment(this.equipment, this.spec);


  @override
  String toString() {
    return equipment + " " + spec;
  }
}