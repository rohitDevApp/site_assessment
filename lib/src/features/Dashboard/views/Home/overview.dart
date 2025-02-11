import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';
import '../../../../common_widgets/common.dart';
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
                child: Row(
                  children: [
                    Icon(Icons.add_chart_outlined ,color: Colors.green,),
                    CustomText(
                        " Overview", 19, FontWeight.bold, Colors.green)
                  ],
                ),
              ),
            ],
          ),
          SizeBox(10),
          RowWithBox("Teams", 13, "Reports", 10),
          SizeBox(25),
          RowWithBox("Officers", 13, "", 0),
        ],
      ),
    );
  }
}
