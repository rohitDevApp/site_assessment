import 'package:flutter/material.dart';

class TabScreen extends StatelessWidget{
  final String label;
  final IconData? icon;
  const TabScreen(this.label,this.icon, {super.key});

  @override
  Widget build(BuildContext context) {
    return  NavigationDestination(
        icon: Icon(
          icon,
          color: Colors.black,
          size: 28,
        ),
        label: label);
  }

}