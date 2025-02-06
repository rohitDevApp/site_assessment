import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';
import 'package:site_assessment/src/common_widgets/RowText.dart';
import 'package:site_assessment/src/common_widgets/common.dart';
import 'package:site_assessment/src/constants/constants.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: ClipRRect(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
      child: Container(
        color: AppColors.mainColor,
        padding: EdgeInsets.all(12),
        child: Column(
          children: [
            Row(
              children: [
                ClipOval(
                  child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(8),
                    child: Icon(
                      Icons.person,
                      size: 50,
                      color: AppColors.mainColor,
                    ),
                  ),
                ),
              ],
            ),
            SizeBox(22),
            RowText("Ronit", 18, FontWeight.bold, Colors.white),
            RowText("rohit@centocode.com", 14, FontWeight.bold, Colors.white),
            RowText("write a about", 14, FontWeight.bold, Colors.white),
            SizeBox(22),
          ],
        ),
      ),
    ));
  }
}
