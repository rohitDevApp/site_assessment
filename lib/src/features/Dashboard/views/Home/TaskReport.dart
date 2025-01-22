import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';
import '../../../../common_widgets/common.dart';
import '../../../../constants/constants.dart';
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
                child: CustomText(
                    "Task Report", 25, FontWeight.bold, AppColors.mainColor),
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

