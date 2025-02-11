import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:site_assessment/src/api/firebaseApi.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';
import 'package:site_assessment/src/constants/firebase.dart';
import 'package:site_assessment/src/features/Dashboard/views/Tasks/Manager/managerDto.dart';

import '../../../../common_widgets/button/CustomButton.dart';
import '../../../../common_widgets/selectBox/selectDto.dart';
import '../../../../constants/constants.dart';

class SingleTask extends StatefulWidget {
  final ManagerDto task;
  final bool isManager;
  const SingleTask(this.task, this.isManager, {super.key});

  @override
  State<StatefulWidget> createState() => SingleTaskState();
}

class SingleTaskState extends State<SingleTask> {
  final TextEditingController statusController =
      TextEditingController(text: "Status");
  bool isStatusSelected = true;
  int isChangeStatus = 0;

  final TextEditingController officerController = TextEditingController();
  final List<SelectLabel> officerList = [];

  @override
  void initState() {
    setTaskActionStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.task.taskAction);
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 1),
      leading: SizedBox(
        height: 48,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
          Icon(
            Icons.pending_actions_outlined,
            color: AppColors.mainColor,
          ),
        ]),
      ),
      title: SizedBox(
        height: 58,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText("Officer Name : ${widget.task.taskAssignOfficer} ", 13,
                FontWeight.bold, Colors.black54),
            CustomText("Site Name : ${widget.task.taskName} ", 13,
                FontWeight.bold, Colors.black54),
            CustomText(
                "Date : ${DateFormat('MMM d, yyyy ').format(widget.task.taskDate)} ",
                12,
                FontWeight.bold,
                Colors.black54),
          ],
        ),
      ),
      trailing: SizedBox(
        height: 48,
        child: widget.isManager
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomText(" ( Task Status ) ", 12, FontWeight.bold,
                      AppColors.mainColor),
                  widget.task.taskAction == "Pending"
                      ? Icon(
                          Icons.cancel_outlined,
                          color: Colors.red,
                        )
                      : widget.task.taskAction == "Done"
                          ? Icon(
                              Icons.check_circle_outline,
                              color: Colors.green,
                            )
                          : Icon(Icons.hourglass_empty, color: Colors.blue)
                ],
              )
            : Column(
                children: [
                  CustomButton(
                      statusController.text,
                      () => handlerStatus(),
                      isChangeStatus == 0
                          ? Colors.red
                          : isChangeStatus == 1
                              ? Colors.green
                              : Colors.orange,
                      13),
                ],
              ),
      ),
    );
  }

//handlerStatus
  Future<void> handlerStatus() async {
    if (isChangeStatus == 2) {
      setState(() {
        isChangeStatus = 0;
        statusController.text = "Pending";
      });
    } else {
      setState(() {
        isChangeStatus += 1;
        if (isChangeStatus == 1) {
          statusController.text = "Done";
        } else if (isChangeStatus == 0) {
          statusController.text = "Pending";
        } else {
          statusController.text = "Progress";
        }
      });
    }
    try {
      await FireBaseApi.updateByField(FireBaseConstant.taskCollection,
          {"action": statusController.text}, widget.task.taskId);
    } catch (err) {
      print("error when update task Status $err");
    }
  }

  //initial Level
  void setTaskActionStatus() {
    int tempStatus = 0;
    String tempText = "Pending";
    if (widget.task.taskAction == "Done") {
      tempStatus = 1;
      tempText = "Done";
    } else if (widget.task.taskAction == "Pending") {
      tempStatus = 0;
      tempText = "Pending";
    } else if (widget.task.taskAction == "Progress") {
      tempStatus = 2;
      tempText = "Progress";
    }

    setState(() {
      isChangeStatus = tempStatus;
      statusController.text = tempText;
    });
  }
}
