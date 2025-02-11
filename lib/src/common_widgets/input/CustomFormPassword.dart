import 'package:flutter/material.dart';
import 'package:site_assessment/src/constants/constants.dart';

import '../CustomText.dart';

class CustomFormPassword extends StatefulWidget {
  final TextEditingController _controller;
  final TextEditingController? confirmController;
  final String hintText;
  final bool obscureText;
  final IconData? icon;

  //Constructor
  const CustomFormPassword(
    this._controller,
    this.hintText,
    this.icon, {
    super.key,
    this.confirmController,
    this.obscureText = true,
  });
  @override
  State<StatefulWidget> createState() => CustomFormPasswordState();
}

//State
class CustomFormPasswordState extends State<CustomFormPassword> {
  bool obscureText = true;
  late FocusNode _focusNode;

  @override
  void initState() {
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool isFocused = _focusNode.hasFocus;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 6,
      children: [
        CustomText(widget.hintText, 15, FontWeight.bold, Colors.black54),
        TextFormField(
          obscureText: obscureText,
          controller: widget._controller,
          focusNode: _focusNode,
          decoration: InputDecoration(
            prefixIcon: Icon(
              widget.icon,
              color: isFocused ? AppColors.mainColor:Colors.black54,
            ),
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
