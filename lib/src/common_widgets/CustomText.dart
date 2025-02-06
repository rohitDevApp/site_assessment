import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? alignment;

  const CustomText(this.text, this.fontSize, this.fontWeight, this.color,
      {this.alignment = TextAlign.start, super.key});
  @override
  Widget build(BuildContext context) {
    return Text(
      softWrap: true,
      textAlign: alignment,
      text,
      style:
          TextStyle(color: color, fontSize: fontSize, fontWeight: fontWeight),
    );
  }
}
