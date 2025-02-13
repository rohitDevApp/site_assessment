import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color bg;
  final VoidCallback onPress;

  //Constructor
  const CustomButton(this.text, this.bg, this.onPress,{super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: bg),
        onPressed: onPress,
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 30,vertical: 2),child: Text(
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
