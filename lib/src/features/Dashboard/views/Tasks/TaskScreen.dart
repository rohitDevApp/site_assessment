import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';

import '../../../../constants/constants.dart';
import '../../../../utils/user.dart';
import 'TaskView.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});
  @override
  State<StatefulWidget> createState() => TaskState();
}

//TaskState
class TaskState extends State<TaskScreen> {
  bool isManager = false;
  bool isRefresh = false;

  @override
  void initState() {
    getRole();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.only(top: 10),
          child: CustomText(isManager ? "Manager Tasks " : "Officer Tasks ", 18,
              FontWeight.bold, AppColors.mainColor),
        ),
        backgroundColor: AppColors.lightBlue,
        leading: Padding(
          padding: EdgeInsets.only(left: 20, top: 10),
          child: Icon(
            Icons.task_alt,
            color: AppColors.mainColor,
          ),
        ),
      ),
      body: SafeArea(
        child: Stack(
          children: [
            TaskView(isManager,isRefresh),
            isManager
                ? Positioned(
                    bottom: 20,
                    right: 20,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.mainColor),
                        onPressed: () =>
                            Navigator.pushNamed(context, DashRoutes.addTask)
                                .then((result) {
                                  print("result is $result");
                                      if (result == true) {setState(() {
                                        isRefresh=!isRefresh;
                                      });}
                                    }),
                        child: Row(
                          spacing: 8,
                          children: [
                            Icon(
                              Icons.add,
                              size: 20,
                              color: Colors.white,
                            ),
                            CustomText("Add", 15, FontWeight.bold, Colors.white)
                          ],
                        )))
                : Container(),
          ],
        ),
      ),
    );
  }

  //getRole
  Future<void> getRole() async {
    try {
      var userData = await CurrentUser.get();
      var role = userData['role'];
      setState(() {
        if (role == "Manager") {
          isManager = true;
        } else {
          isManager = false;
        }
      });
    } catch (err) {
      print("err when fetch data from the task collection");
    }
  }
}
