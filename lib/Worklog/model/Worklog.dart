
import 'package:dooromi/Partner/model/Partner.dart';
import 'package:dooromi/Worklog/model/Equipment.dart';
import 'package:intl/intl.dart';

class Worklog {
  int? id;
  String date;
  String startTime;
  String endTime;
  String? location;
  Equipment? equipment;
  Partner? partner;

  Worklog(this.date, this.startTime, this.endTime);

  setId(id){
    this.id = id;
  }

  setLocation(location){
    this.location = location;
  }

  setEquipment(equipment){
    this.equipment = equipment;
  }

  setPartner(partner){
    this.partner = partner;
  }

  String forDialog(){
    return
            "근무일자 : " + date + "\n"
          + "근무시간 : " + startTime + " ~ " + endTime + "\n"
          + "근무장소 : " + location! + "\n"
          + "근무장비 : " + equipment!.equipment + " " + equipment!.spec + "\n"
          + "근무거래처 : " + partner!.companyName + "\n";
  }

  @override
  String toString() {
    return
          "id : " + id.toString() + "\n"
        + "근무일자 : " + date + "\n"
        + "근무시간 : " + startTime + " ~ " + endTime + "\n"
        + "근무장소 : " + location! + "\n"
        + "근무장비 : " + equipment!.toString() + "\n"
        + "근무거래처 : " + partner!.companyName +  "\n";
  }

  Map<String, dynamic> toJson() => {
    "id" : this.id.toString(),
    "startedAt" : this.date.trimRight()+ "T" + this.startTime + ":00",
    "finishedAt" :  this.date.trimRight()+ "T" + this.endTime + ":00",
    "equipmentId" : this.equipment!.id,
    "location" : this.location,
    "partnerId" : this.partner!.id
  };

  static List<Worklog> fromJson(Map<String, dynamic> response) {
    List<dynamic> body = response['worklogDtoList'];
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');
    final DateFormat timeFormatter = DateFormat('HH:mm');

    List<Worklog> worklogList = [];

    for (var value in body) {
      String startDateAndTime = value['startDate'];
      String endDateAndTime = value['endDate'];

      print("hour " + DateTime.parse(startDateAndTime).hour.toString());

      Worklog worklog =
        new Worklog(
          dateFormatter.format(DateTime.parse(startDateAndTime)),
          timeFormatter.format(DateTime.parse(startDateAndTime)),
          timeFormatter.format(DateTime.parse(endDateAndTime)));
      worklog.setId(value['id']);
      worklog.setLocation(value['workLocationDto']['gu'] + " "
          + value['workLocationDto']['dong']);

      worklog.setEquipment(
          new Equipment(
             1,
              value['heavyEquipmentDto']['equipmentType'],
              value['heavyEquipmentDto']['weight'].toString()
                  +
                  value['heavyEquipmentDto']['equipmentUnit']));

      worklog.setPartner(Partner.simplePartner(value['partnerId'], ""));

      worklogList.add(worklog);
    }
    return worklogList;
  }
}