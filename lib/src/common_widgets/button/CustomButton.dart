import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color bg;
  final double padding;
  final VoidCallback onPressed;

  //Constructor
  const CustomButton(this.text, this.onPressed, this.bg,this.padding, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: bg),
        onPressed: onPressed,
        child: Padding(padding: EdgeInsets.symmetric(horizontal: padding,vertical: 2),child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            decorationColor: Colors.black54,
          ),
        ),));
  }
}
