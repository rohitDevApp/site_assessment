import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_assessment/src/features/Dashboard/Provider/user/user_provider.dart';
import 'package:site_assessment/src/features/Dashboard/views/Reports/Manager/ManagerReports.dart';
import 'Officer/OfficerReport.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<StatefulWidget> createState() => ReportsState();
}

//ReportsState
class ReportsState extends State<ReportsScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          userProvider.userData!['role'] == "Manager"
              ? ManagerReports()
              : OfficerReport(),
        ],
      )),
    );
  }
}
