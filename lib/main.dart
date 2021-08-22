import 'package:dooromi/Partner/page/PartnerListPage.dart';
import 'package:dooromi/User/page/LoginPage.dart';
import 'package:dooromi/Worklog/page/DateAndTimePage.dart';
import 'package:flutter/material.dart';

import 'User/page/JoinPage.dart';


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
      home: new MyHomePage()
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var _index = 0;
  var _pages = [
    JoinPage(),
    DateAndTimePage(),
    PartnerListPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Scaffold(
          body: _pages[_index],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (index){
              setState(() {
                _index = index;
              });
            },
            currentIndex: _index,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle),
                  label: '내정보',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.assignment),
                  label: '근무일지'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.people),
                  label: '거래처관리'
              ),
            ],
          ),
        )
    );
  }
}