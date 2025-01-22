import 'package:flutter/material.dart';

class HomeHeader extends StatelessWidget {
  final String role;
  const HomeHeader(this.role, {super.key});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: MediaQuery.of(context).size.height * 0.05,
          child: Container(
            padding: EdgeInsets.all(25),
            child: Text(
              "Welcome Good Morning ! \nRonit $role ",
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ) ,Positioned(
          right: 0,
          child: Container(
            padding: EdgeInsets.all(25),
            child: Icon(Icons.notifications_active ,size: 40,color: Colors.white,),
          ),
        )
      ],
    );
  }
}
