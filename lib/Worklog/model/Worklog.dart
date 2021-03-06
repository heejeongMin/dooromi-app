
import 'package:dooromi/Partner/model/Partner.dart';
import 'package:dooromi/HeavyEquipment/model/Equipment.dart';
import 'package:intl/intl.dart';

class Worklog {
  int? id;
  String date;
  String workTime;
  String? location;
  Equipment? equipment;
  double? workPay = 0.0;
  Partner? partner;
  String? createdAt;


  Worklog(this.date, this.workTime);

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

  setWorkPay(workPay){
    this.workPay = workPay;
  }

  setCreatedAt(createdAt){
    this.createdAt = createdAt;
  }

  String forDialog(){
    return
            "근무일자 : " + date + "\n"
          + "근무시간 : " + workTimeKR() + "\n"
          + "근무장소 : " + location! + "\n"
          + "근무장비 : " + equipment!.equipmentKR() + " " + equipment!.spec + "\n"
          + "근무거래처 : " + partner!.companyName + "\n"
          + "금액 : " + workPay.toString() + "\n";
  }

  @override
  String toString() {
    return
          "id : " + id.toString() + "\n"
        + "근무일자 : " + date + "\n"
        + "근무시간 : " + workTime + "\n"
        + "근무장소 : " + location! + "\n"
        + "근무장비 : " + equipment!.toString() + "\n"
        + "근무거래처 : " + partner!.companyName +  "\n";
  }

  Map<String, dynamic> toJson() => {
    "id" : this.id.toString(),
    "workDate" : this.date,
    "workTime" : this.workTime,
    "equipmentId" : this.equipment!.id,
    "location" : this.location,
    "partnerId" : this.partner!.id,
    "workPay" : this.workPay
  };

  static List<Worklog> fromJson(Map<String, dynamic> response) {
    List<dynamic> body = response['worklogDtoList'];
    final DateFormat dateFormatter = DateFormat('yyyy-MM-dd');

    List<Worklog> worklogList = [];

    for (var value in body) {
      String createdAt = value['createdAt'];
      String workTime = value['workTime'];


      Worklog worklog =
        new Worklog(dateFormatter.format(DateTime.parse(createdAt)), workTime);
      worklog.setId(value['id']);
      worklog.setLocation(value['workLocationDto']['gu'] + " "
          + value['workLocationDto']['dong']);

      worklog.setEquipment(
          new Equipment(
             value['heavyEquipmentDto']['id'],
              value['heavyEquipmentDto']['equipmentType'],
              value['heavyEquipmentDto']['weight'].toString()
                  +
                  value['heavyEquipmentDto']['equipmentUnit'],
          value['heavyEquipmentDto']['halfDayAmount'],
          value['heavyEquipmentDto']['fullDayAmount'],
          value['heavyEquipmentDto']['nightShiftAmount'],
          value['heavyEquipmentDto']['createdAt']));

      worklog.setPartner(Partner.simplePartner(value['partnerId'], ""));

      worklogList.add(worklog);
    }
    return worklogList;
  }

  String workTimeKR(){
    if(workTime == 'DAY'){
      return "하루";
    } else if(workTime == 'NIGHT') {
      return "야간";
    } else {
      return "반나절";
    }
  }
}