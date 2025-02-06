import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';
import 'package:site_assessment/src/common_widgets/common.dart';
import 'package:site_assessment/src/features/Dashboard/views/Tasks/Manager/ManagerTask.dart';

import '../../../../constants/constants.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<StatefulWidget> createState() => TaskState();
}

//TaskState
class TaskState extends State<TaskScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
         child: Stack(
           children: [
             ManagerTask()
           ],
         ),),
    );
  }
}
