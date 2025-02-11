import 'package:flutter/material.dart';
import 'package:site_assessment/src/api/firebaseApi.dart';
import 'package:site_assessment/src/constants/constants.dart';
import 'package:site_assessment/src/constants/firebase.dart';
import 'package:site_assessment/src/features/Dashboard/views/Tasks/TaskView.dart';
import 'package:site_assessment/src/utils/user.dart';

import '../../../../../common_widgets/DateSelectorWithInput.dart';
import '../../../../../common_widgets/selectBox/DynamicSelectBox.dart';
import '../../../../../common_widgets/button/CustomButton.dart';
import '../../../../../common_widgets/common.dart';
import '../../../../../common_widgets/selectBox/selectDto.dart';
import '../TaskScreen.dart';

class TaskForm extends StatefulWidget {
  const TaskForm({super.key});

  @override
  State<StatefulWidget> createState() => TaskFormState();
}

//TaskForm STate
class TaskFormState extends State<TaskForm> {
  final TextEditingController taskController = TextEditingController();
  final TextEditingController taskDateController = TextEditingController();
  final TextEditingController officerController = TextEditingController();
  final List<SelectLabel> officerList = [];
  final addTaskFormKey = GlobalKey<FormState>();
  bool isOfficerSelected = true;
  SelectLabel? selectedOfficer;
  bool isLoading = false;

  @override
  void initState() {
    getOfficer();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: addTaskFormKey,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              SizeBox(60),
              InputFormField(taskController, "Task Name",Icons.task_outlined),
              SizeBox(20),
              DateSelectorWithInput(taskDateController, "Select Task Date"),
              SizeBox(20),
              DynamicSelectBox<SelectLabel>("Assign Officer", officerController,
                  (SelectLabel? officer) {
                setState(() {
                  selectedOfficer = officer;
                });
              }, isOfficerSelected, officerList, (item) => item.label),
              SizeBox(30),
              Row(
                mainAxisAlignment: isLoading
                    ? MainAxisAlignment.center
                    : MainAxisAlignment.end,
                children: [
                  isLoading
                      ? CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation(AppColors.mainColor))
                      : CustomButton("Add Task", () {
                          if (addTaskFormKey.currentState!.validate()) {
                            if (officerController.text.isEmpty) {
                              setState(() {
                                isOfficerSelected = false;
                              });
                              return;
                            }
                            setState(() {
                              isOfficerSelected = true;
                            });
                            handlerTask();
                          }
                        }, AppColors.mainColor, 30)
                ],
              )
            ],
          ),
        ));
  }

  //getOfficer
  Future<void> getOfficer() async {
    List<SelectLabel> tempSelect = [];
    try {
      var user = await CurrentUser.get();
      var allOfficer = await FireBaseApi.getByField(
          FireBaseConstant.teamsCollection, "managerId", user['userId']);
      for (var officer in allOfficer) {
        tempSelect.add(SelectLabel(officer['officerId'], officer['fullName']));
        print("officer is ${officer['officerId']}");
      }
    } catch (e) {
      print("$e is when all officer at Add Task");
    }

    setState(() {
      officerList.addAll(tempSelect);
    });
  }

  //handlerTask
  Future<void> handlerTask() async {
    setState(() {
      isLoading = true;
    });
    var user = await CurrentUser.get();
    Map<String, dynamic> taskData = {
      "action": "Status",
      "taskName": taskController.text,
      "taskDate": taskDateController.text,
      "officerName": officerController.text,
      "officerId": selectedOfficer?.id,
      "managerId": user['userId'],
    };
    try {
      await FireBaseApi.insert(FireBaseConstant.taskCollection, taskData);
      setState(() {
        taskController.clear();
        taskDateController.clear();
        officerController.clear();
        selectedOfficer = null;
      });

      Navigator.pop(context, true);
    } catch (e) {
      print("$e is when all officer at Add Task");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }
}
