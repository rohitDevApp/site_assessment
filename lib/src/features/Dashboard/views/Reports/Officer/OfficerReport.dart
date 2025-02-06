import 'package:flutter/material.dart';
import 'package:site_assessment/src/api/firebaseApi.dart';
import 'package:site_assessment/src/common_widgets/LoadingAnimation.dart';
import 'package:site_assessment/src/constants/firebase.dart';
import 'package:site_assessment/src/features/Dashboard/views/Reports/Officer/FormOfReport.dart';
import 'package:site_assessment/src/utils/SharedPreferencesHelper.dart';
import 'package:site_assessment/src/utils/user.dart';
import '../../../../../common_widgets/DeniedAnimatedPage.dart';
import '../../../../../constants/constants.dart';

class OfficerReport extends StatefulWidget {
  const OfficerReport({super.key});

  @override
  State<StatefulWidget> createState() => OfficerReportState();
}

//OfficerReport State
class OfficerReportState extends State<OfficerReport> {
  bool isTeamMember = false;
  bool isLoading = true;
  @override
  void initState() {
    super.initState();
    checkOfficerTeam();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: Stack(
      children: [
        isLoading ? LoadingAnimation():
        isTeamMember
            ? FormOfReport()
            : DeniedAnimatedPage("Contact To Manager !",
                "You are not under any manager . Please contact your manager for access.")
      ],
    ));
  }

  Future<void> checkOfficerTeam() async {
    bool isTeams = false;
    try {
      var data = await CurrentUser.get();
      var docs = await FireBaseApi.getByField(
          FireBaseConstant.teamsCollection, "officerId", data['userId']);
      await Future.delayed(Duration(milliseconds: 500));

      if(docs[0]['managerId'] != ''){
        await SharedPreferencesHelper.setPrefValue(KEYS.managerId, docs[0]['managerId']);
        isTeams=true;
      }else{
        isTeams=false;
        await SharedPreferencesHelper.setPrefValue(KEYS.managerId, "");
      }

    } catch (err) {
      print("error $err");
      isTeams = false;
      await SharedPreferencesHelper.setPrefValue(KEYS.managerId, "");
    }finally{
      if (mounted) {
        setState(() {
          isTeamMember = isTeams;
          isLoading = false; // Ensure loading is set to false only once
        });
      }

    }
  }
}
