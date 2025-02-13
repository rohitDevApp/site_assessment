import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_assessment/src/common_widgets/LoadingAnimation.dart';
import 'package:site_assessment/src/features/Dashboard/Provider/report/reportProvider.dart';
import 'package:site_assessment/src/features/Dashboard/views/Reports/Officer/FormOfReport.dart';
import '../../../../../common_widgets/DeniedAnimatedPage.dart';

class OfficerReport extends StatefulWidget {
  const OfficerReport({super.key});

  @override
  State<StatefulWidget> createState() => OfficerReportState();
}

//OfficerReport State
class OfficerReportState extends State<OfficerReport> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero,(){
          Provider.of<ReportProvider>(context , listen: false).checkOfficerTeam();
    });
  }

  @override
  Widget build(BuildContext context) {
      final reportProvider = Provider.of<ReportProvider>(context);
    return Scaffold(
        body: Stack(
      children: [
        reportProvider.isLoading ? LoadingAnimation("Report Loading ...",Icons.sync):
        reportProvider.isTeamMember
            ? FormOfReport()
            : DeniedAnimatedPage("Contact To Manager !",
                "You are not under any manager . Please contact your manager for access.")

      ],
    ));
  }
}
