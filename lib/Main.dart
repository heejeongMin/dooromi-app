
import 'package:dooromi/TabNavigatorRoutes.dart';
import 'package:dooromi/User/model/AuthToken.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'User/model/AuthToken.dart';
import 'User/page/LoginPage.dart';


void main() {
  runApp(new MyApp());

}
class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Generated App',
      theme: new ThemeData(
        primaryColor: Colors.white,
      ),
      home: new DooroomiNavigator(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ko', 'KR'),
      ],
    );
  }
}

class DooroomiNavigator extends StatefulWidget {
  @override
  _DooroomiNavigatorState createState()
      => new _DooroomiNavigatorState();
}

class _DooroomiNavigatorState extends State<DooroomiNavigator> {
  int _selectedIndex = 0;
  String _currentPage = "UserProfilePage";
  List<String> pageKeys =
  ["UserProfilePage", "ScheduleListPage", "PartnerListPage"];
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "UserProfilePage": GlobalKey<NavigatorState>(),
    "ScheduleListPage": GlobalKey<NavigatorState>(),
    "PartnerListPage": GlobalKey<NavigatorState>(),
  };

  @override
  void initState() {
    super.initState();
  }

  void _selectTab(String tabItem, int index) {
    if (tabItem == "UserProfilePage") {
      if (AuthToken.token == null || AuthToken.token.isEmpty) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                new LoginPage()),
                (route) => false);
      } else {
        setState(() {
          _currentPage = pageKeys[index];
          _selectedIndex = index;
        });
      }
    } else {
        setState(() {
          _currentPage = pageKeys[index];
          _selectedIndex = index;
        });
      }
  }

    @override
    Widget build(BuildContext context) {
      print(AuthToken.token);
      if (AuthToken.token == null || AuthToken.token.isEmpty) {
        return new LoginPage();
      }
      return WillPopScope(
        onWillPop: () async {
          final isFirstRouteInCurrentTab =
          !await _navigatorKeys[_currentPage]!.currentState!.maybePop();
          if (isFirstRouteInCurrentTab) {
            if (_currentPage != "UserProfilePage") {
              _selectTab("UserProfilePage", 0);
              return false;
            }
          }

          // let system handle back button if we're on the first route
          return isFirstRouteInCurrentTab;
        },
        child: Scaffold(
          body: Stack(
              children: <Widget>[
                _buildOffstageNavigator("UserProfilePage"),
                _buildOffstageNavigator("ScheduleListPage"),
                _buildOffstageNavigator("PartnerListPage"),
              ]
          ),
          bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: Colors.blueAccent,
            onTap: (int index) {
              _selectTab(pageKeys[index], index);
            },
            currentIndex: _selectedIndex,
            items: [
              BottomNavigationBarItem(
                icon: new Icon(Icons.account_circle),
                title: new Text('??????'),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.assignment),
                title: new Text('????????????'),
              ),
              BottomNavigationBarItem(
                icon: new Icon(Icons.people),
                title: new Text('?????????'),
              ),
            ],
            type: BottomNavigationBarType.fixed,
          ),
        ),
      );
    }

    Widget _buildOffstageNavigator(String tabItem) {
      return Offstage(
        offstage: _currentPage != tabItem,
        child: new TabNavigator(
          navigatorKey: _navigatorKeys[tabItem],
          tabItem: tabItem,
        ),
      );
    }
  }

