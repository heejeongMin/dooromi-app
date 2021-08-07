import 'package:dooromi/Worklog/model/Equipment.dart';

class Worklog {
  String date;
  String startTime;
  String endTime;
  String? location;
  Equipment? equipment;

  Worklog(this.date, this.startTime, this.endTime);

  setLocation(location){
    this.location = location;
  }

  setEquipment(Equipment){
    this.equipment = equipment;
  }
}