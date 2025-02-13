import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:site_assessment/src/common_widgets/CustomButton.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';
import 'package:site_assessment/src/common_widgets/SnackBar.dart';
import 'package:site_assessment/src/common_widgets/common.dart';
import 'package:site_assessment/src/features/Dashboard/provider/task/taskProvider.dart';
import 'package:site_assessment/src/features/Dashboard/views/Tasks/taskDto.dart';

import '../../../../../api/firebaseApi.dart';
import '../../../../../common_widgets/button/CustomRadioButton.dart';
import '../../../../../constants/constants.dart';
import '../../../../../constants/firebase.dart';

class ViewTask extends StatefulWidget {
  const ViewTask({super.key});

  @override
  State<StatefulWidget> createState() => ViewTaskState();
}

class ViewTaskState extends State<ViewTask> {
  String taskStatus = "Pending";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      TaskDto task = ModalRoute.of(context)!.settings.arguments as TaskDto;
      setState(() {
        taskStatus = task.taskAction;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    TaskDto task = ModalRoute.of(context)!.settings.arguments as TaskDto;

    return Scaffold(
        appBar: AppBar(
          titleSpacing: 2,
          leadingWidth: 38,
          title: CustomText("${task.taskName} Task", 18, FontWeight.bold,
              AppColors.mainColor),
          iconTheme: IconThemeData(color: AppColors.mainColor),
        ),
        body: SafeArea(
            child: Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Card(
              color: AppColors.lightBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.task_alt,
                          color: AppColors.mainColor,
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        CustomText(task.taskName, 16, FontWeight.bold,
                            AppColors.mainColor)
                      ],
                    ),
                    SizeBox(12),
                    const Divider(
                      color: Colors.blue,
                    ),
                    SizeBox(12),
                    TaskField("Task Name", task.taskName),
                    SizeBox(4),
                    TaskField("Task Date",
                        DateFormat('MMM d, yyyy ').format(task.taskDate)),
                    SizeBox(4),
                    TaskField("Officer Name", task.taskAssignOfficer),
                    SizeBox(4),
                    TaskField("Task Status", taskStatus),
                    SizeBox(14),
                    const Divider(
                      color: Colors.blue,
                    ),
                    SizeBox(12),
                    TaskField("Task Status", ""),
                    Column(
                      children: [
                        CustomRadioButton("Completed", taskStatus, (value) {
                          setState(() {
                            taskStatus = value.toString();
                          });
                        }),
                        CustomRadioButton("Progress", taskStatus, (value) {
                          setState(() {
                            taskStatus = value.toString();
                          });
                        }),
                        CustomRadioButton("Pending", taskStatus, (value) {
                          setState(() {
                            taskStatus = value.toString();
                          });
                        })
                      ],
                    ),
                    SizeBox(14),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomButton("Change Status", AppColors.mainColor, () {
                          handleTaskStatus(task.taskId);
                        })
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        )));
  }

//   //handlerStatus
  Future<void> handleTaskStatus(String id) async {
    try {
      await FireBaseApi.updateByField(
          FireBaseConstant.taskCollection, {"action": taskStatus}, id);
      CustomSnackBar.show(context, "Updated", position: "bottom", bg: "green");
      Provider.of<TaskProvider>(context, listen: false).getAllTasks();
    } catch (err) {
      print("error when update task Status $err");
    }
  }
}

//TaskField
class TaskField extends StatelessWidget {
  final String field;
  final String value;
  const TaskField(this.field, this.value, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomText("$field : ", 16, FontWeight.bold, Colors.black87),
        CustomText(value, 16, FontWeight.bold, Colors.black54)
      ],
    );
  }
}
