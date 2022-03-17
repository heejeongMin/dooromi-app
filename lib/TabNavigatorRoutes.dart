import 'package:dooromi/User/model/AuthToken.dart';
import 'package:dooromi/User/page/LoginPage.dart';
import 'package:flutter/material.dart';

import 'Partner/page/PartnerListPage.dart';
import 'User/page/UserProfilePage.dart';
import 'Worklog/page/ScheduleListPage.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
}

class TabNavigator extends StatelessWidget {
  final GlobalKey<NavigatorState>? navigatorKey;
  final String tabItem;

  TabNavigator({required this.navigatorKey, required this.tabItem});


  @override
  Widget build(BuildContext context) {
    Widget child = LoginPage();

    if(tabItem == "LoginPage")
      child = LoginPage();
    else if(tabItem == "UserProfilePage")
      child = UserProfilePage(user: AuthToken.user);
    else if(tabItem == "ScheduleListPage")
      child = ScheduleListPage();
    else if(tabItem == "PartnerListPage")
      child = PartnerListPage();

    return Navigator(
      key: navigatorKey,
      onGenerateRoute: (routeSettings) {
        return
          MaterialPageRoute(
            settings: RouteSettings(name: "/"+tabItem),
            builder: (context) => child,
          );
      },
    );
  }
}