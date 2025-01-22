import 'package:flutter/material.dart';
import 'package:site_assessment/src/features/Dashboard/views/Reports/ManagerReports.dart';
import 'package:site_assessment/src/features/Dashboard/views/Reports/OfficerReport.dart';
import '../../../../utils/user.dart';

class ReportsScreen extends StatefulWidget{
  const ReportsScreen({super.key});

  @override
  State<StatefulWidget> createState() => ReportsState();
}

//ReportsState
class ReportsState extends State<ReportsScreen>{
  @override
  void initState() {
    getUserInfo();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child:Container(
            padding: EdgeInsets.only(top: 25 ,right: 10,left: 10 ),
            child: Stack(
              children: [
               ManagerReports(),
                // OfficerReport(),
              ],
            ),
          )
          ),
    );
  }

  void getUserInfo() async{
    var data = await CurrentUser.get();
    print("$data data in Reports");
  }
}
