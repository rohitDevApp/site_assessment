import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_assessment/src/common_widgets/common.dart';
import 'package:site_assessment/src/constants/constants.dart';
import 'package:site_assessment/src/features/Dashboard/Provider/user/user_provider.dart';

import '../../../../common_widgets/LoadingAnimation.dart';
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

  @override
  void initState() {
    super.initState();
    Future.microtask((){
      Provider.of<UserProvider>(context,listen: false).fetchUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    if(userProvider.userData == null) return LoadingAnimation("Home Loading ...",Icons.account_circle);
    return Scaffold(
      body: SafeArea(
          child: Container(
        color: AppColors.mainColor,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: [
            HomeHeader(userProvider.userData?['role'] ?? "NA",  userProvider.userData?['fullName'] ?? "NA",),
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
