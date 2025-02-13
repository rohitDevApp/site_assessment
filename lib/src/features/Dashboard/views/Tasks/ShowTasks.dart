import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:site_assessment/src/common_widgets/LoadingAnimation.dart';
import 'package:site_assessment/src/features/Dashboard/provider/task/taskProvider.dart';
import 'SingleTask.dart';

class ShowTasks extends StatefulWidget {
  const ShowTasks({super.key});

  @override
  State<StatefulWidget> createState() => ShowTasksState();
}

class ShowTasksState extends State<ShowTasks> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      Provider.of<TaskProvider>(context, listen: false).getAllTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    final taskProvider = Provider.of<TaskProvider>(context);
    if (taskProvider.isLoading == null)
      return LoadingAnimation("Task fetching ...", Icons.task_alt);
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(7),
        child: Column(
          children: [
            Expanded(
                child: ListView.builder(
                    itemCount: taskProvider.getAllTask.length,
                    itemBuilder: (BuildContext context, int index) {
                      if (index >= taskProvider.getAllTask.length) {
                        return SizedBox();
                      }
                      final task = taskProvider.getAllTask[index];
                      return Column(
                        children: [
                          SingleTask(task),
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
}
