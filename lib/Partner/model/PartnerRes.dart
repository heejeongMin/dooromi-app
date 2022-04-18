

import 'Partner.dart';

class PartnerRes {
  late List<Partner> partners;

  static PartnerRes fromJson(Map<String, dynamic> response) {
    List<dynamic> body = response['partners'];
    List<Partner> partnerList = [];

    for (var value in body) {
      partnerList.add(new Partner.of(
          value['id'],
          value['partnerNumber'],
          value['companyName'],
          value['ceoName'],
          value['phoneNumber'],
          value['createdBy']
      ));
    }

    PartnerRes res = new PartnerRes();
    res.partners = partnerList;
    return res;
  }
}