//Custom Snack bar
import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';

import '../constants/constants.dart';

class CustomSnackBar {
  static void show(BuildContext context, String message,
      {String bg = "white", String position = "top"}) {
    double? top, bottom;
    Color? color;

    //position
    if (position == "top") {
      top = MediaQuery.of(context).padding.top + 40;
    } else if (position == "bottom") {
      bottom = MediaQuery.of(context).padding.bottom + 40;
    } else {
      top = (MediaQuery.of(context).size.height / 2) - 40;
    }

    //color
    if (bg == 'red') {
      color = Colors.red;
    } else if (bg == 'green') {
      color = Colors.green;
    } else {
      color = AppColors.mainColor;
    }


    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: top,
        left: 45,
        right: 45,
        bottom: bottom,
        child: Material(
          color: Colors.transparent,
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Center(
                child: CustomText(message, 16, FontWeight.bold, Colors.white),
              )),
        ),
      ),
    );

    // Insert the overlay entry
    Overlay.of(context).insert(overlayEntry);

    // Remove it after a delay
    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}

//Small
class ActionSnackBar {
  static void show(
    BuildContext context,
    String message,
  ) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        left: MediaQuery.of(context).size.width * 0.3,
        right: MediaQuery.of(context).size.width * 0.3,
        bottom: 12,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 4,
                  // offset: Offset(0, 2),
                ),
              ],
            ),
            child: Center(
                child: Row(
              spacing: 5,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(message, 15, FontWeight.bold, Colors.black54),
                Icon(
                  Icons.add_task_sharp,
                  color: Colors.black54,
                  size: 15,
                ),
              ],
            )),
          ),
        ),
      ),
    );

    // Insert the overlay entry
    Overlay.of(context).insert(overlayEntry);

    // Remove it after a delay
    Future.delayed(Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }
}
