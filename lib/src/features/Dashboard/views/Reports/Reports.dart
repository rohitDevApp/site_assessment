import 'package:flutter/material.dart';
import 'package:site_assessment/src/features/Dashboard/views/Reports/Manager/ManagerReports.dart';
import '../../../../utils/user.dart';
import 'Officer/OfficerReport.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<StatefulWidget> createState() => ReportsState();
}

//ReportsState
class ReportsState extends State<ReportsScreen> {
  var role;

  @override
  void initState() {
    super.initState();
    getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
            children: [
              role == "Manager" ? ManagerReports() : OfficerReport(),
            ],
          )),
    );
  }

  void getUserInfo() async {
    var data = await CurrentUser.get();
    setState(() {
      role = data['role'];
    });
  }
}
