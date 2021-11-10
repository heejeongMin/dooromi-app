import 'dart:convert';

import 'package:dooromi/Worklog/model/WorklogRes.dart';
import 'package:dooromi/Worklog/page/ScheduleListPage.dart';
import 'package:http/http.dart' as http;
import 'package:dooromi/Worklog/model/Worklog.dart';
import 'package:dooromi/Worklog/page/WorklogDetailPage.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class DooroomiAPI {
  static final localhost = 'http://10.0.2.2:7070';
  static final uri = '/crane/v1/worklog';

  static Future<WorklogRes> getAllWorklog(offset) async {
    var now = DateTime.now();

    final queryParam = {
      'startDate': now.subtract(const Duration(days: 90)).toIso8601String(),
      'endDate': now.add(const Duration(days: 1)).toIso8601String(),
      'page': offset.toString(),
      'size': '8'
    };

    print("queryParam : " + queryParam.toString());

    final response = await http.get(
        localhost + uri + "?" + Uri(queryParameters: queryParam).query,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });

    print(jsonDecode(utf8.decode(response.bodyBytes)));

    return WorklogRes.fromJson(jsonDecode(utf8.decode(response.bodyBytes)));
  }

  static saveWorklog(Worklog worklog, BuildContext prevContext) {
    Future<http.Response> response = fetchPost(worklog);

    response.then((value) {
      if(value.statusCode != 201) {
        print(value);
      }
        String message = value.statusCode == 201? "성공적으로 저장되었습니다." : "저장에 실패하였습니다.";

        showDialog(
          context: prevContext,
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
                    Navigator.of(context).pop();
                    // Navigator.of(context).push(
                    //     MaterialPageRoute(
                    //       builder: (BuildContext context) => new WorklogDetailPage(worklog: worklog),
                    //     ));

                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => new DooroomiNavigator()),
                            (route) => false);

                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //       builder: (context) =>
                    //       new WorklogDetailPage(worklog: worklog)),
                    // );
                  },
                ),
              ],
          );
        });


    });

  }

  static Future<http.Response> fetchPost(Worklog worklog) async {
    return await http.post(Uri.parse(localhost + uri),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(worklog.toJson()));
  }

  static deleteWorklog(Worklog worklog, BuildContext prev) {


    final response = http.delete(
        localhost + uri + "?" + Uri(queryParameters: {'ids': worklog.worklogNumber.toString()}).query,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        });


      response.then((value) {
        if(value.statusCode != 200) {
          print(value);
      }

      String message = (value.statusCode == 200) ? "성공적으로 삭제되었습니다." : "삭제에 실패하였습니다.";

      showDialog(
          context: prev,
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
                    Navigator.of(context).pop();
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => new DooroomiNavigator()),
                            (route) => false);

                  },
                ),
              ],
            );
          });
    });


  }
}
