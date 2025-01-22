import 'package:flutter/material.dart';

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
      body: SafeArea(child: Container(
        padding: EdgeInsets.all(25),
        child: Stack(
          children: [
            Text("Tasks")
          ],
        ),
      )),
    );
  }
}
