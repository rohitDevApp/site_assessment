import 'package:flutter/material.dart';
import 'package:site_assessment/src/constants/constants.dart';
import 'package:site_assessment/src/features/Dashboard/views/Dashboard/tabs.dart';
import 'package:site_assessment/src/features/Dashboard/views/Home/Home.dart';
import 'package:site_assessment/src/features/Dashboard/views/Notification/Notifications.dart';
import 'package:site_assessment/src/features/Dashboard/views/Reports/Reports.dart';
import 'package:site_assessment/src/features/Dashboard/views/Settings/Settings.dart';
import 'package:site_assessment/src/features/Dashboard/views/Tasks/Tasks.dart';

import '../Teams/Teams.dart';
import 'Drawer.dart';


class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<StatefulWidget> createState() => DashboardState();
}

//Home Screen State
class DashboardState extends State<Dashboard> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Future<String?> role;
  var userRole = "No User";
  int index = 0;

  final screens = [
    HomeScreen(),
    ReportsScreen(),
    TaskScreen(),
    // NotificationsScreen(),
    SettingScreen(),
    TeamScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Scaffold(
        drawer: CustomDrawer(),
        onDrawerChanged: (bool isOpen){
          if(!isOpen){
            setState(() {
              index=0;
            });
          }
        },
        key: _scaffoldKey,
        body: screens[index],
        bottomNavigationBar: NavigationBarTheme(
            data: NavigationBarThemeData(
                indicatorColor: Colors.purple.shade200,
                labelTextStyle: WidgetStateProperty.all(TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.purple))),
            child: NavigationBar(
                height: 65,
                selectedIndex: index,
                backgroundColor: Colors.purple.shade100,
                onDestinationSelected: (index) {
                  if(index == 3){
                    _scaffoldKey.currentState?.openDrawer();
                  }
                    setState(() => this.index = index);},
                destinations: [
                  TabScreen(DashRoutes.home ,Icons.home),
                  TabScreen(DashRoutes.reports ,Icons.menu_book),
                  TabScreen(DashRoutes.tasks,Icons.add_task_sharp),
                  // TabScreen(DashRoutes.notification,Icons.notifications_active_outlined),
                  TabScreen(DashRoutes.setting,Icons.settings),
                ])),
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

