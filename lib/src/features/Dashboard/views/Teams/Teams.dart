import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';
import 'package:site_assessment/src/constants/constants.dart';
import 'package:site_assessment/src/features/Dashboard/views/Teams/AllOfficer.dart';
import 'package:site_assessment/src/features/Dashboard/views/Teams/MyOfficer.dart';

class TeamScreen extends StatefulWidget {
  const TeamScreen({super.key});

  @override
  State<StatefulWidget> createState() => TeamState();
}

//Teams State
class TeamState extends State<TeamScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 12),
        color: Colors.white,
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: ()=>Navigator.pop(context),
          icon: Icon(Icons.arrow_back, size: 28, color: Colors.black54),
        ),
        title: CustomText(
            "Team Management", 22, FontWeight.bold, Colors.black54),
        bottom: TabBar(
          indicatorColor: AppColors.mainColor,
          unselectedLabelColor: Colors.black54,
          labelStyle:TextStyle(color:Colors.black87 ,fontSize: 16, fontWeight: FontWeight.bold) ,
          controller: _tabController,
          tabs: [
            Tab(text: 'All Officer' ),
            Tab(text: 'My Officer'),
          ],
        ),
      ),
      body: SafeArea(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: TabBarView(
              controller: _tabController,
              children: [
                AllOfficer(),
                MyOfficer(),
              ],
            ),
          )),
    ));
  }
}
