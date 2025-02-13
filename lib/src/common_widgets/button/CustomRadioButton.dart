import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';

import '../../constants/constants.dart';

class CustomRadioButton extends StatelessWidget {
  final String label;
  final String groupValue;
  final ValueChanged<String?> onChanged;
  const CustomRadioButton(this.label,this.groupValue,this.onChanged,{super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: CustomText(label, 12, FontWeight.bold, AppColors.mainColor),
      leading: Radio(activeColor:AppColors.mainColor,value: label, groupValue: groupValue, onChanged: onChanged)
      );
  }
}




