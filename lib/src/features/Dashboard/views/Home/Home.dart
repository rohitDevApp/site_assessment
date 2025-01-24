import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/common.dart';
import 'package:site_assessment/src/constants/constants.dart';
import 'package:site_assessment/src/utils/user.dart';

import 'HomeHeader.dart';
import 'TaskReport.dart';
import 'overview.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => HomeState();
}

//HomeState
class HomeState extends State<HomeScreen> {
  String role = "No Role";
  String fullName = "NA";

  //getUserInfo
  void getUserInfo() async {
    var data = await CurrentUser.get();
    setState(() {
      role = data['role'] ?? 'No Role';
      fullName = data['fullName'] ?? 'NA';
    });
  }

  @override
  void initState() {
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: AppColors.mainColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            HomeHeader(role, fullName),
            Positioned(
                top: MediaQuery.of(context).size.height * 0.22,
                bottom: 0,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(35),
                    topLeft: Radius.circular(35),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(35),
                        topLeft: Radius.circular(35),
                      ),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [SizeBox(15), Overview(),SizeBox(15),  TasksReport()],
                      ),
                    ),
                  ),
                )),
          ],
        ),
      )),
    );
  }
}
