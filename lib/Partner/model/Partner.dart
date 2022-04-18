import 'package:dooromi/HeavyEquipment/model/Equipment.dart';
import 'package:intl/intl.dart';

class Partner {
  int? id;
  String? partnerNumber;
  String companyName = "";
  String ceoName = "";
  String phoneNumber = "";
  int? createdBy;
  DateTime? deletedAt;

  Partner(
      this.companyName,
      this.ceoName,
      this.phoneNumber);

  static Partner simplePartner (int id, String companyName) {
    Partner partner = new Partner(companyName, "", "");
    partner.id = id;
    return partner;
  }

  Partner.ofSimple(int id, String partnerNumber, String companyName){
    this.id = id;
    this.partnerNumber = partnerNumber;
    this.companyName = companyName;
  }

  Partner.of(int id, String partnerNumber, String companyName, String ceoName,
      String phoneNumber, int createdBy){
    this.id = id;
    this.partnerNumber = partnerNumber;
    this.companyName = companyName;
    this.ceoName = ceoName;
    this.phoneNumber = phoneNumber;
    this.createdBy = createdBy;
  }

  Map<String, dynamic> toJson() => {
    "id" : this.id?.toString(),
    "partnerNumber": this.partnerNumber?.toString(),
    "companyName" :  this.companyName.trim(),
    "ceoName" : this.ceoName.trim(),
    "phoneNumber" : this.phoneNumber.trim()
  };

  String forDialog(){
    return
          "거래처명 : " + companyName + "\n"
          + "사장님명 : " + ceoName + "\n"
          + "전화번호 : " + phoneNumber + "\n";
  }
}
