import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';
import '../../../../common_widgets/common.dart';
import 'RowWithBox.dart';

class TasksReport extends StatelessWidget {
  const TasksReport({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.only(right: 12, left: 12, top: 12),
                child: Row(
                  children: [
                    Icon(Icons.task_alt ,color: Colors.red,),
                    CustomText(
                        " Task Report", 19, FontWeight.bold, Colors.red)
                  ],
                ),
              ),
            ],
          ),
          SizeBox(10),
          RowWithBox("Tasks", 13, "Completed", 10),
          SizeBox(25),
          RowWithBox("Pending", 13, "Progress", 15),
        ],
      ),
    );
  }
}

