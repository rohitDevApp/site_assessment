import 'package:flutter/material.dart';

import '../../constants/constants.dart';
import '../CustomText.dart';

class CustomFormInput extends StatefulWidget{
  final TextEditingController _controller;
  final String hintText;
  final IconData? icon;
  const CustomFormInput(this._controller, this.hintText, this.icon,{super.key});

  @override
  State<StatefulWidget> createState() =>CustomFormInputState();
}

class CustomFormInputState extends State<CustomFormInput>{
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {});
    });
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
          controller: widget._controller,
          focusNode: _focusNode,
          decoration: InputDecoration(
              prefixIcon: Icon(widget.icon ,color: isFocused? AppColors.mainColor: Colors.black54,),
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
              return '${widget.hintText} Required ';
            }

            //Email
            if (trimmedValue.isNotEmpty &&
                widget.hintText == "Email" &&
                !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(trimmedValue)) {
              return 'Enter a valid email!';
            }

            return null;
          },
          autovalidateMode: AutovalidateMode.onUserInteraction,
        )
      ],
    );
  }
}
