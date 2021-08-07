import 'package:flutter/material.dart';

import 'Worklog/page/DateAndTimePage.dart';

void main() {
  runApp(new MyApp());

}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Generated App',
      theme: new ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: new DateAndTimePage(),
    );
  }
}