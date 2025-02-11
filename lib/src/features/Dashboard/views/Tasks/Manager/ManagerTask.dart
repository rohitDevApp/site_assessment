import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:site_assessment/src/api/firebaseApi.dart';
import 'package:site_assessment/src/constants/firebase.dart';
import 'package:site_assessment/src/features/Dashboard/views/Tasks/Manager/managerDto.dart';
import 'package:site_assessment/src/utils/user.dart';

import '../SingleTask.dart';

class ManagerTask extends StatefulWidget {
  const ManagerTask({super.key});

  @override
  State<StatefulWidget> createState() => ManagerState();
}

class ManagerState extends State<ManagerTask> {
  final List<ManagerDto> arrManagerTasks = [];

  @override
  void initState() {
    getManagerTask();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(7),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: arrManagerTasks.length,
                    itemBuilder: (BuildContext context, int index) {
                      final task = arrManagerTasks[index];
                      return Column(
                        children: [
                          SingleTask(task,true),
                          Divider(
                            thickness: 0.6,
                          )
                        ],
                      );
                    })),

          ],
        ),
      ),
    );
  }

  //getManagerTask
  Future<void> getManagerTask() async {
    List<ManagerDto> tempManagerTasks = [];

    try{
      var userData = await CurrentUser.get();
      bool isManager = userData['role'] == "Manager";
      var allTask = await FireBaseApi.getByField(FireBaseConstant.taskCollection, isManager ? "managerId" : "officerId", userData['userId']);
      for(var task in allTask){
        DateTime taskDate = DateFormat("d/M/yyyy").parse(task['taskDate']);
        tempManagerTasks
            .add(ManagerDto(task['taskName'], task.id, "Pending", taskDate , task['officerName'],''));
      }
    }catch(err){
      print("err when fetch data from the task collection");
    }
    setState(() {
      arrManagerTasks.addAll(tempManagerTasks);
    });
  }
}
