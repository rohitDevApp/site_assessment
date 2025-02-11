import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:site_assessment/src/api/firebaseApi.dart';
import 'package:site_assessment/src/constants/firebase.dart';
import 'package:site_assessment/src/features/Dashboard/views/Tasks/Manager/managerDto.dart';
import 'package:site_assessment/src/utils/user.dart';
import 'SingleTask.dart';

class TaskView extends StatefulWidget {
  final bool isManager;
  final bool isRefresh;
  const TaskView(this.isManager,this.isRefresh,{super.key});

  @override
  State<StatefulWidget> createState() => TaskViewState();
}

class TaskViewState extends State<TaskView> {
  final List<ManagerDto> arrManagerTasks = [];

  @override
  void initState() {
    getAllTasks();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TaskView oldWidget) {
   if(widget.isRefresh != oldWidget.isRefresh){
     getAllTasks();
   }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(7),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: arrManagerTasks.length,
                    itemBuilder: (BuildContext context, int index) {
                      final task = arrManagerTasks[index];
                      return Column(
                        children: [
                          SingleTask(task , widget.isManager),
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
  Future<void> getAllTasks() async {
    List<ManagerDto> tempManagerTasks = [];
    arrManagerTasks.length=0;
    print("call all task ");
    try{
      var userData = await CurrentUser.get();
      bool isManager = userData['role'] == "Manager";
      var allTask = await FireBaseApi.getByField(FireBaseConstant.taskCollection, isManager ? "managerId" : "officerId", userData['userId']);
      for(var task in allTask){
        DateTime taskDate = DateFormat("d/M/yyyy").parse(task['taskDate']);
        tempManagerTasks
            .add(ManagerDto(task['taskName'], task.id, "Pending", taskDate , task['officerName'],task['action']));
      }
    }catch(err){
      print("err when fetch data from the task collection $err");
    }
    setState(() {
      arrManagerTasks.addAll(tempManagerTasks);
    });
  }
}
