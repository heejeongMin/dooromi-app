
import 'package:dooromi/TabNavigatorRoutes.dart';
import 'package:dooromi/User/model/AuthToken.dart';
import 'package:flutter/material.dart';


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
      home: new DooroomiNavigator()
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
  String _currentPage = "LoginPage";
  List<String> pageKeys =
  ["LoginPage", "ScheduleListPage", "PartnerListPage"];
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "LoginPage": GlobalKey<NavigatorState>(),
    "UserProfilePage": GlobalKey<NavigatorState>(),
    "ScheduleListPage": GlobalKey<NavigatorState>(),
    "PartnerListPage": GlobalKey<NavigatorState>(),
  };

  @override
  void initState() {
    super.initState();
  }

  void _selectTab(String tabItem, int index) {
    if(tabItem == "LoginPage"){
      _navigatorKeys[tabItem]!.currentState!
          .popUntil((route) => route.isFirst);

      if(AuthToken.token.isEmpty) {
        setState(() {
          _currentPage = pageKeys[0];
          _selectedIndex = index;
        });
      } else {
        setState(() {
          _currentPage = "UserProfilePage";
          _selectedIndex = 0;
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
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
        !await _navigatorKeys[_currentPage]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != "LoginPage") {
              _selectTab("LoginPage", 0);

            // if(AuthToken.token.isEmpty) {
            //   _selectTab("LoginPage", 0);
            // } else {
            //   _selectTab("UserProfilePage", 0);
            // }

            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(
        children:<Widget>[
        _buildOffstageNavigator("LoginPage"),
          _buildOffstageNavigator("UserProfilePage"),
        _buildOffstageNavigator("ScheduleListPage"),
        _buildOffstageNavigator("PartnerListPage"),
        ]
      ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: Colors.blueAccent,
          onTap: (int index) { _selectTab(pageKeys[index], index); },
          currentIndex: _selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: new Icon(Icons.account_circle),
              title: new Text('개인'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.assignment),
              title: new Text('근무일정'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.people),
              title: new Text('거래처'),
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
