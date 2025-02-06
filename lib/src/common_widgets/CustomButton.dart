import 'package:flutter/material.dart';
import 'package:site_assessment/src/constants/constants.dart';

class CustomButton extends StatelessWidget {
  final String routeName;
  final String text;
  final Color bg;

  //Constructor
  const CustomButton(this.text, this.routeName, this.bg, {super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: bg),
        onPressed: () => Navigator.pushNamed(context, routeName),
        child: Padding(padding: EdgeInsets.symmetric(horizontal: 30,vertical: 2),child: Text(
          text,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
            decoration: TextDecoration.underline,
            decorationColor: Colors.black54,
          ),
        ),));
  }
}
