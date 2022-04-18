import 'dart:convert';

import 'package:dooromi/Partner/model/Partner.dart';
import 'package:dooromi/Partner/model/PartnerRes.dart';
import 'package:dooromi/User/model/AuthToken.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import '../../main.dart';

class PartnerApi {
  static final localHost = '10.0.2.2:7070';
  static final herokuHost = 'peaceful-mesa-17441.herokuapp.com';
  static final partnerUri = '/crane/v1/partner';

  static createPartner(Partner partner, BuildContext context) async {
    Future<http.Response> response = createPartnerWithPOST(partner);

    response.then((value) {
      if(value.statusCode != 201) {
        print(value);
      }
      String message = value.statusCode == 201? "성공적으로 저장되었습니다." : "저장에 실패하였습니다.";

      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text(''),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    Text(message),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context, rootNavigator: true).pop();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                            new DooroomiNavigator()),
                            (route) => false);
                  },
                ),
              ],
            );
          });
    });
  }

  static Future<http.Response> createPartnerWithPOST(
      Partner partner) async {
    return await http.post(Uri.http(herokuHost, partnerUri),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + AuthToken.token
        },
        body: jsonEncode(partner.toJson()));
  }

  static Future<PartnerRes> getAllPartner(offset) async {
    final queryParam = {
      'page': '0',
      'size': '100'
    };

    final response = await http.get(
        Uri.http(herokuHost, partnerUri, queryParam),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + AuthToken.token
        });

    print(jsonDecode(utf8.decode(response.bodyBytes)));
    return PartnerRes.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

}
