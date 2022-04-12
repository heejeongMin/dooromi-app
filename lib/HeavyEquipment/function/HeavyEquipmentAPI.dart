import 'dart:convert';

import 'package:dooromi/HeavyEquipment/model/HeavyEquipmentCreateReq.dart';
import 'package:dooromi/HeavyEquipment/model/HeavyEquipmentRes.dart';
import 'package:dooromi/User/model/AuthToken.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';

class HeavyEquipmentAPI {
  static final localHost = '10.0.2.2:7070';
  static final herokuHost = 'peaceful-mesa-17441.herokuapp.com';
  static final heavyEquipmentUri = '/crane/v1/heavyEquipment';

  static Future<HeavyEquipmentRes> getAllHeavyEquipment() async {
    final response = await http.get(
        Uri.http(herokuHost, heavyEquipmentUri),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + AuthToken.token
        });


    return HeavyEquipmentRes.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  static createHeavyEquipment(HeavyEquipmentCreateReq req, BuildContext context) async {
    Future<http.Response> response = createHeavyEquipmentWithPOST(req);

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


  static Future<http.Response> createHeavyEquipmentWithPOST(
      HeavyEquipmentCreateReq heavyEquipmentCreateReq) async {
    return await http.post(Uri.http(herokuHost, heavyEquipmentUri),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer ' + AuthToken.token
        },
        body: jsonEncode(heavyEquipmentCreateReq.toJson()));
  }
}
