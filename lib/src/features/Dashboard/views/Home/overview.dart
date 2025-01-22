import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';
import '../../../../common_widgets/common.dart';
import '../../../../constants/constants.dart';
import 'RowWithBox.dart';

class Overview extends StatelessWidget {
  const Overview({super.key});

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
                    "Overview", 25, FontWeight.bold, AppColors.mainColor),
              ),
            ],
          ),
          SizeBox(10),
          RowWithBox("Teams", 13, "", 10),
          SizeBox(25),
          RowWithBox("Officers", 13, "Reports", 0),
        ],
      ),
    );
  }
}
