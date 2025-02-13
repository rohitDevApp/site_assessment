import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';
import 'package:site_assessment/src/features/Dashboard/Provider/user/user_provider.dart';
import 'package:site_assessment/src/features/Dashboard/views/Tasks/taskDto.dart';

import '../../../../constants/constants.dart';

class SingleTask extends StatefulWidget {
  final TaskDto task;
  const SingleTask(this.task, {super.key});

  @override
  State<StatefulWidget> createState() => SingleTaskState();
}

class SingleTaskState extends State<SingleTask> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    Color? statusColor;
    //Status color
    if (widget.task.taskAction == "Pending") {
      statusColor = Colors.orange;
    } else if (widget.task.taskAction == "Completed") {
      statusColor = Colors.green;
    } else {
      statusColor = AppColors.mainColor;
    }

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
          child: userProvider.userData!['role'] == "Manager"
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CustomText(widget.task.taskAction, 15, FontWeight.bold,
                        statusColor),
                  ],
                )
              : Column(
                  children: [
                    TextButton(onPressed: ()=>Navigator.pushNamed(context, DashRoutes.viewTask,arguments: widget.task), child: CustomText("View Task ", 12, FontWeight.bold, AppColors.mainColor))
                  ],
                )
          ),
    );
  }
}
