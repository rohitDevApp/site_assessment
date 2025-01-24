import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';
import 'package:site_assessment/src/constants/constants.dart';

Future<void> showDialogBox(
    BuildContext context, String title, String message ,Function(bool) onConfirm) async {
  return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: CustomText(title, 18, FontWeight.normal, Colors.black87),
          content: Text(message),
          actions: <Widget>[
            ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onConfirm(false);
                },
                child: Text("Cancel")),
            ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: AppColors.mainColor),
                onPressed: () {
                  Navigator.of(context).pop();
                  onConfirm(true);
                },
                child: CustomText("Yes", 12, FontWeight.bold, Colors.white)),
          ],
        );
      });
}
