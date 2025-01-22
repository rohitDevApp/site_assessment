import 'package:flutter/cupertino.dart';

class RowText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  final Color? color;
  const RowText(this.text, this.fontSize, this.fontWeight, this.color,
      {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          text,
          style: TextStyle(
              color: color, fontSize: fontSize, fontWeight: fontWeight),
        )
      ],
    );
  }
}
