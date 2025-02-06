//Custom Snack bar
import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';

import '../constants/constants.dart';

class CustomSnackBar {
  static void show(BuildContext context, String message,
      {String bg = "white"}) {
    OverlayEntry overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 40,
        left: 45,
        right: 45,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: bg == 'red' ? Colors.red : AppColors.mainColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Center(child: CustomText(message, 16, FontWeight.bold, Colors.white),)
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
                CustomText(message, 15, FontWeight.bold,Colors.black54),
                Icon(Icons.add_task_sharp ,color: Colors.black54 ,size: 15,),
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
