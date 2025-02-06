import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'CustomText.dart';

class NumberInput extends StatelessWidget {
  final TextEditingController _controller;
  final String hintText;

  //Constructor
  const NumberInput(this._controller, this.hintText, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6,
      children: [
        CustomText(hintText, 15, FontWeight.bold, Colors.black54),
        TextFormField(
          controller: _controller,
          decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 12),
              // hintText: hintText,
              fillColor: Colors.white,
              filled: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: AppColors.mainColor),
                borderRadius: BorderRadius.circular(8),
              )),
          validator: (value) {
            String trimmedValue = value?.trim() ?? '';

            if (trimmedValue.isEmpty) {
              return '$hintText Required ';
            }

            //Email
            if (trimmedValue.isNotEmpty &&
                !RegExp(r"^[0-9]*$")
                    .hasMatch(trimmedValue)) {
              return 'Enter a only number !';
            }

            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
        )
      ],
    );
  }
}
