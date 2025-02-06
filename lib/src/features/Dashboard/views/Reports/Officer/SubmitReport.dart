import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';
import 'package:site_assessment/src/constants/constants.dart';

class SubmitReport extends StatefulWidget {
  const SubmitReport({super.key});

  @override
  State<StatefulWidget> createState() => SubmitReportState();
}

//state
class SubmitReportState extends State<SubmitReport> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.lightBlue,
      height: MediaQuery.of(context).size.height * 0.8,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipOval(
                child: Container(
                  padding: EdgeInsets.all(12),
                  color: AppColors.mainColor,
                  child: Icon(
                    Icons.check,
                    size: 62,
                    color: Colors.green,
                  ),
                ),
              ),
            ],
          ),

          CustomText(
              "Today Report Generated", 22, FontWeight.bold, AppColors.mainColor)
        ],
      ),
    );
  }
}
