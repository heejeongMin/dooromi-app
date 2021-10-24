

import 'dart:convert';

import 'package:dooromi/Worklog/model/WorklogRes.dart';
import 'package:http/http.dart' as http;
import 'package:dooromi/Worklog/model/Worklog.dart';
import 'package:dooromi/Worklog/page/WorklogDetailPage.dart';
import 'package:flutter/material.dart';



class DoroomiAPI {

  static final localhost = 'http://10.0.2.2:7070';
  // static final localhost = 'http://localhost:8080';
  static final uri = '/crane/v1/worklog';

  static Future<WorklogRes> getAllWorklog(offset) async {
    var now = DateTime.now();


    final queryParam = {
      'startDate' : now.subtract(const Duration(days: 90)).toIso8601String(),
      'endDate' : now.add(const Duration(days: 1)).toIso8601String(),
      'page' : offset.toString(),
      'size' : '8'
    };

    print(queryParam);

    final response = await http.get(
        localhost + uri + "?" + Uri(queryParameters: queryParam).query,
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
        }
    );

   return WorklogRes.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }


  static saveWorklog(Worklog worklog, BuildContext context) {

    fetchPost(worklog);

    String message = (true)? "성공적으로 저장되었습니다." : "저장에 실패하였습니다.";

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
                onPressed: (){
                  Navigator.of(context).pop();
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => new WorklogDetailPage(worklog: worklog))
                  );
                },
              ),
            ],
          );
        }
    );
  }


  static Future<bool> fetchPost(Worklog worklog) async {

    final response =  http.post(
        Uri.parse(localhost + uri),
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(worklog.toJson())
    );

    response.then((value) => {
      print(value.body)
    });

    bool result = true;
    response.onError((error, stackTrace) =>
      throw Exception('Fail to save')
    );

    return result;
  }

}
