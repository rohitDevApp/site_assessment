import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';

class SnackBarHelper {
 static void show (String message ,String title ,{snackPosition = SnackPosition.TOP}){
   final bg = title == 'Success' ? Colors.green : Colors.red;
    Get.snackbar(
      title,
      message,
      snackPosition: snackPosition,
      backgroundColor: bg,
      colorText: Colors.white,
      borderRadius: 8,
      margin: const EdgeInsets.all(12),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 4),
      duration: const Duration(seconds: 1),
      icon: const Icon(Icons.check_circle, color: Colors.white),
      messageText: CustomText(message, 15, FontWeight.bold, Colors.white)
    );
  }
}