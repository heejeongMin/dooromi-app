

import 'Partner.dart';

class PartnerRes {
  late int totalItems;
  late List<Partner> partners;

  static PartnerRes fromJson(Map<String, dynamic> response) {
    List<dynamic> body = response['partnerDtoList'];
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
    res.totalItems = response['totalItems'];
    return res;
  }
}