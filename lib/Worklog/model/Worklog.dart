
import 'package:dooromi/Worklog/model/Equipment.dart';
import 'package:intl/intl.dart';

class Worklog {
  int? worklogNumber;
  String date;
  String startTime;
  String endTime;
  String? location;
  Equipment? equipment;
  String? client;

  Worklog(this.date, this.startTime, this.endTime);

  setWorklogNumber(worklogNumber){
    this.worklogNumber = worklogNumber;
  }

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
          "id : " + worklogNumber.toString() + "\n"
        + "근무일자 : " + date + "\n"
        + "근무시간 : " + startTime + " ~ " + endTime + "\n"
        + "근무장소 : " + location! + "\n"
        + "근무장비 : " + equipment!.toString() + "\n"
        + "근무거래처 : " + "\n";
  }

  Map<String, dynamic> toJson() => {
    "id" : this.worklogNumber.toString(),
    "startDate" : this.date.trimRight()+ "T" + this.startTime + ":00",
    "endDate" :  this.date.trimRight()+ "T" + this.endTime + ":00",
    "equipmentId" : this.equipment?.id.toString(),
    // "heavyEquipmentDto" : {
    //   'equipmentType' : 'CRANE',
    //   'weight' : this.equipment?.spec.replaceAll("T", ""),
    //   'equipmentUnit' : 'TON',
    //   'priceDto' : {
    //     'pricePerUnit' : 300000,
    //     'unit' : 'WON'
    //   }
    // },
    "city" : "",
    "gu" : "",
    "dong" : this.location
  };

  static List<Worklog> fromJson(Map<String, dynamic> response) {
    List<dynamic> body = response['worklogDtoList'];
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
    final DateFormat timeFormatter = DateFormat('H:m');

    List<Worklog> worklogList = [];

    for (var value in body) {
      String startDateAndTime = value['startDate'];
      String endDateAndTime = value['endDate'];

      Worklog worklog =
        new Worklog(
          dateFormatter.format(DateTime.parse(startDateAndTime)),
          timeFormatter.format(DateTime.parse(startDateAndTime)),
          timeFormatter.format(DateTime.parse(endDateAndTime)));

      worklog.setLocation(value['workLocationDto']['gu'] + " "
          + value['workLocationDto']['dong']);

      worklog.setEquipment(
          new Equipment(
             1,
              value['heavyEquipmentDto']['equipmentType'],
              value['heavyEquipmentDto']['weight'].toString()
                  +
                  value['heavyEquipmentDto']['equipmentUnit']));

      worklogList.add(worklog);
    }
    return worklogList;
  }
}