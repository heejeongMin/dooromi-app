
import 'package:dooromi/tab_navigator.dart';
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
  _DooroomiNavigatorState createState() => _DooroomiNavigatorState();
}

class _DooroomiNavigatorState extends State<DooroomiNavigator> {
  int _selectedIndex = 0;
  String _currentPage = "JoinPage";
  List<String> pageKeys = ["JoinPage", "ScheduleListPage", "PartnerListPage"];
  Map<String, GlobalKey<NavigatorState>> _navigatorKeys = {
    "JoinPage": GlobalKey<NavigatorState>(),
    "ScheduleListPage": GlobalKey<NavigatorState>(),
    "PartnerListPage": GlobalKey<NavigatorState>(),
  };

  void _selectTab(String tabItem, int index) {
    if(tabItem == _currentPage ){
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() {
        _currentPage = pageKeys[index];
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    print("main.dart");
    return WillPopScope(
      onWillPop: () async {
        print("onWillPop");
        final isFirstRouteInCurrentTab =
        !await _navigatorKeys[_currentPage]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          if (_currentPage != "JoinPage") {
            _selectTab("JoinPage", 1);

            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(
        children:<Widget>[
        _buildOffstageNavigator("JoinPage"),
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
              title: new Text('JoinPage'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.assignment),
              title: new Text('ScheduleListPage'),
            ),
            BottomNavigationBarItem(
              icon: new Icon(Icons.people),
              title: new Text('PartnerListPage'),
            ),
          ],
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(String tabItem) {
    print("_buildOffstageNavigator");

    return Offstage(
      offstage: _currentPage != tabItem,
      child: new TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }
}

// class _DooroomiNavigatorState extends State<DooroomiNavigator> {
//   var _index = 0;
//   final List<Widget> _pages = [
//     JoinPage(),
//     ScheduleListPage(),
//     PartnerListPage(),
//   ];
//
//   void onTabTapped(int index){
//     setState(() {
//       _index = index;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//           body: _pages[_index],
//           bottomNavigationBar: BottomNavigationBar(
//             onTap: onTabTapped,
//             currentIndex: _index,
//             items: [
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.account_circle),
//                 label: '내정보',
//               ),
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.assignment),
//                   label: '근무일지'
//               ),
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.people),
//                   label: '거래처관리'
//               ),
//             ],
//           ),
//         );
//
//
//
//
//     // return DefaultTabController(
//     //     length: 3,
//     //     child: Scaffold(
//     //       body: _pages[_index],
//     //       bottomNavigationBar: BottomNavigationBar(
//     //         onTap: (index){
//     //           setState(() {
//     //             _index = index;
//     //           });
//     //         },
//     //         currentIndex: _index,
//     //         items: [
//     //           BottomNavigationBarItem(
//     //               icon: Icon(Icons.account_circle),
//     //               label: '내정보',
//     //           ),
//     //           BottomNavigationBarItem(
//     //               icon: Icon(Icons.assignment),
//     //               label: '근무일지'
//     //           ),
//     //           BottomNavigationBarItem(
//     //               icon: Icon(Icons.people),
//     //               label: '거래처관리'
//     //           ),
//     //         ],
//     //       ),
//     //     )
//     // );
//   }
// }