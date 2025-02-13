import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';

import '../../../../constants/constants.dart';
import '../../Provider/user/user_provider.dart';
import 'ShowTasks.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});
  @override
  State<StatefulWidget> createState() => TaskState();
}

//TaskState
class TaskState extends State<TaskScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Padding(
          padding: EdgeInsets.only(top: 10),
          child: CustomText(
              userProvider.userData!['role'] == "Manager"
                  ? "Manager Tasks "
                  : "Officer Tasks ",
              18,
              FontWeight.bold,
              AppColors.mainColor),
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
            ShowTasks(),
            userProvider.userData!['role'] == "Manager"
                ? Positioned(
                    bottom: 20,
                    right: 20,
                    child: SizedBox(
                      height: 50,
                      width: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(0),
                            backgroundColor: AppColors.mainColor),
                        onPressed: () =>
                            Navigator.pushNamed(context, DashRoutes.addTask),
                        child: Icon(
                          Icons.add,
                          size: 30,
                          color: Colors.white,
                        ),
                      ),
                    ))
                : Container(),
          ],
        ),
      ),
    );
  }
}
