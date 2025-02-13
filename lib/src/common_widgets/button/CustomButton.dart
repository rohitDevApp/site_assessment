import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color bg;
  final double padding;
  final VoidCallback onPressed;
  final double width;

  //Constructor
  const CustomButton(this.text, this.onPressed, this.bg,this.padding,this.width, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: bg),
          onPressed: onPressed,
          child: Padding(padding: EdgeInsets.symmetric(horizontal: padding,vertical: 2),child: Text(
            text,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              decorationColor: Colors.black54,
            ),
          ),)),
    );
  }
}
