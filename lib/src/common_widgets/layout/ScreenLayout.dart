import 'package:flutter/material.dart';

class ScreenLayout extends StatelessWidget {
  final Widget child;
  const ScreenLayout({required this.child, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: EdgeInsets.all(20),
        child: child,
      )),
    );
  }
}
