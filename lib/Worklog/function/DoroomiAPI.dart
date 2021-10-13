

import 'dart:collection';
import 'dart:convert';
import 'dart:math';

import 'package:dooromi/Worklog/page/ScheduleListPage.dart';
import 'package:http/http.dart' as http;
import 'package:dooromi/Worklog/model/Worklog.dart';
import 'package:dooromi/Worklog/page/WorklogDetailPage.dart';
import 'package:flutter/material.dart';



class DoroomiAPI {

  static final localhost = 'http://10.0.2.2:7070';
  // static final localhost = 'http://localhost:8080';
  static final uri = '/crane/v1/worklog';

  static Future<List<Worklog>> getAllWorklog() async {

    final queryParam = {
      'startDate' : '2021-10-04T10:46:00',
      'endDate' : '2021-10-20T03:00:00',
      'page' : '0',
      'size' : '20'
    };

    final response = await http.get(
        localhost + uri + "?" + Uri(queryParameters: queryParam).query,
        headers: <String, String> {
          'Content-Type': 'application/json; charset=UTF-8',
        }
    );

   return Worklog.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
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
    worklog.startTime = '2021-10-18T10:46:00';
    worklog.endTime = '2021-10-19T10:46:00';

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
