import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'CustomText.dart';

class Password extends StatefulWidget {
  final TextEditingController _controller;
  final TextEditingController? confirmController;
  final String hintText;
  final bool obscureText;

  //Constructor
  const Password(
    this._controller,
    this.hintText, {
    super.key,
    this.confirmController,
    this.obscureText = true,
  });
  @override
  State<StatefulWidget> createState() => PasswordState();
}

//State
class PasswordState extends State<Password> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6,
      children: [
        CustomText(widget.hintText, 15, FontWeight.bold, Colors.black54),
        TextFormField(
          obscureText: obscureText,
          controller: widget._controller,
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
            ),
            suffixIcon: IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.black54,
              ),
              onPressed: () {
                setState(() {
                  obscureText = !obscureText;
                });
              },
            ),
          ),
          validator: (value) {
            String trimmedValue = value?.trim() ?? '';

            if (trimmedValue.isEmpty) {
              return '${widget.hintText} Required ';
            }

            //Password
            if (["New Password", "Password"].contains(widget.hintText) &&
                !RegExp(r'^(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
                    .hasMatch(trimmedValue)) {
              return 'Password must be strong';
            }

            //Confirm Password
            if (widget.confirmController?.text != value &&
                widget.hintText == 'Confirm Password') {
              return 'Password does not match';
            }
            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
        )
      ],
    );
  }
}
