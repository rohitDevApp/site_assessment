import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';
import 'package:site_assessment/src/constants/constants.dart';
import 'package:site_assessment/src/features/Dashboard/views/Tasks/Manager/TaskForm.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<StatefulWidget> createState() => AddTaskState();
}

//AddTaskState
class AddTaskState extends State<AddTaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: 0,
          title: Padding(
            padding: EdgeInsets.only(top: 25),
            child: CustomText("Add Task ", 18, FontWeight.bold, Colors.blue),
          ),
          leading: Padding(
            padding: EdgeInsets.only(top: 20),
            child: IconButton(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back ,size: 26,),
              color: AppColors.mainColor,
            ),
          ),
        ),
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Stack(
            children: [
              TaskForm()
            ],
          ),
        )));
  }
}
