import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../../api/firebaseApi.dart';
import '../../../../constants/firebase.dart';
import '../../../../utils/user.dart';
import '../../views/Tasks/taskDto.dart';

class TaskProvider with ChangeNotifier {
  final List<TaskDto> _arrAllTasks = [];
  List<TaskDto> get getAllTask => _arrAllTasks;

  bool? _isLoading;
  bool? get isLoading =>_isLoading;



  //fetch all task
  Future<void> getAllTasks() async {
    List<TaskDto> tempAllTask = [];
    _arrAllTasks.length=0;
    try {
      var userData = await CurrentUser.get();
      bool isManager = userData['role'] == "Manager";
      var allTask = await FireBaseApi.getByField(
          FireBaseConstant.taskCollection,
          isManager ? "managerId" : "officerId",
          userData['userId']);
      if(allTask.toString() != _arrAllTasks.toString()){
        _isLoading = true;
        for (var task in allTask) {
          try {
            DateTime taskDate = DateFormat("d/M/yyyy").parse(task['taskDate']);
            tempAllTask.add(TaskDto(task['taskName'], task.id, "Pending",
                taskDate, task['officerName'], task['action']));
          } catch (dateError) {
            print("Date parsing error: $dateError for task: ${task['taskDate']}");
          }
        }
        _arrAllTasks.addAll(tempAllTask);
      }

    } catch (err) {
      print("err when fetch data from the task collection $err");
    }
_isLoading=false;
    notifyListeners();
  }



}
