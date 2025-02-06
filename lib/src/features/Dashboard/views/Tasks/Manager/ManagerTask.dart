import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';
import 'package:site_assessment/src/common_widgets/common.dart';
import 'package:site_assessment/src/constants/constants.dart';

class ManagerTask extends StatefulWidget {
  const ManagerTask({super.key});

  @override
  State<StatefulWidget> createState() => ManagerState();
}

class ManagerState extends State<ManagerTask> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              spacing: 10,
              children: [
                Icon(
                  Icons.task_alt,
                  color: AppColors.mainColor,
                ),
                CustomText(
                    "Manager Tasks ", 18, FontWeight.bold, AppColors.mainColor)
              ],
            ),
            SizeBox(20),
            Expanded(
                child: ListView.builder(
                    itemCount: 4,
                    itemBuilder: (BuildContext context, int index) {
                      return ListTile(
                        leading: Icon(Icons.add_chart_outlined),
                        title: Text("Task Name"),
                        subtitle: Text("Task Date "),
                        trailing: Text("Status"),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
