import 'package:dooromi/Worklog/model/Equipment.dart';

class Worklog {
  int? worklogNumber;
  String date;
  String startTime;
  String endTime;
  String? location;
  Equipment? equipment;
  String? client;

  Worklog(this.date, this.startTime, this.endTime);

  setLocation(location){
    this.location = location;
  }

  setEquipment(equipment){
    this.equipment = equipment;
  }

  setClient(client){
    this.client = client;
  }

  @override
  String toString() {
    return
          "근무일자 : " + date + "\n"
        + "근무시간 : " + startTime + " ~ " + endTime + "\n"
        + "근무장소 : " + location! + "\n"
        + "근무장비 : " + equipment!.toString() + "\n"
        + "근무거래처 : " + client!;
  }
}