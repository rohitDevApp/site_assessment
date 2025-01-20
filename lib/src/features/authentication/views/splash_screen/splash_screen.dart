import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:site_assessment/src/constants/image_string.dart';
import 'package:site_assessment/src/features/authentication/controllers/splash_screen_controller.dart';


class SplashScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=>SplashScreenState();
}
class SplashScreenState extends State<SplashScreen> {
  bool animate =false;

  @override
  void initState() {
  startAnimation();
  }
  @override
  Widget build(BuildContext context) {
    // splashController.startAnimation();
    return Scaffold(
        body: SafeArea(
            child: Stack(
      children: [
        AnimatedPositioned(
            duration: const Duration(milliseconds: 1000),
            top: !animate
                ? 0
                : MediaQuery.of(context).size.height * 0.1,
            left: 20,
            child: SizedBox(
              width: 150,
              height: 150,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Image(
                  image: AssetImage(splashScreen),
                  fit: BoxFit.cover,
                ),
              ),
            )),
       AnimatedPositioned(
              duration: const Duration(milliseconds: 2000),
              top: MediaQuery.of(context).size.height * 0.12,
              right: animate ? 20 : 60,
              child: SizedBox(
                  height: 100,
                  width: 100,
                  child: ClipOval(
                    child: Image(
                      image: AssetImage(splashScreen4),
                      fit: BoxFit.cover,
                    ),
                  )),
        ),
     AnimatedPositioned(
            duration: const Duration(milliseconds: 2000),
            top: MediaQuery.of(context).size.height * 0.3,
            left: animate ? 20 : 80,
            child: Column(
              children: [
                Text(
                  "Welcome To ! \nSite Assessment App",
                  style: TextStyle(fontSize: 22),
                ),
              ],
            )), AnimatedPositioned(
            duration: const Duration(milliseconds: 2000),
            top: MediaQuery.of(context).size.height * 0.4,
            right: animate ? 20 : 80,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: SizedBox(
                width: 300,
                height: 300,
                child: Image(
                  image: AssetImage(splashScreen2),
                  fit: BoxFit.cover,
                ),
              ),
            )),
       AnimatedPositioned(
            duration: const Duration(milliseconds: 2000),
            top: MediaQuery.of(context).size.height * 0.8,
            left: animate ? 20 : 80,
            child: SizedBox(
                height: 100,
                width: 100,
                child: ClipOval(
                  child: Image(
                    image: AssetImage(splashScreen3),
                    fit: BoxFit.cover,
                  ),
                ))),
        AnimatedPositioned(
              duration: const Duration(milliseconds: 2000),
              top: MediaQuery.of(context).size.height * 0.8,
              right: animate ? 20 : 80,
              child: SizedBox(
                  height: 100,
                  width: 100,
                  child: ClipOval(
                    child: Image(
                      image: AssetImage(splashScreen4),
                      fit: BoxFit.cover,
                    ),
                  )),
        )
      ],
    )));
  }

  //Start Animation
  Future startAnimation() async {
      await Future.delayed(Duration(milliseconds: 500));
      setState(() {
        animate=true;
      });
      await Future.delayed(Duration(milliseconds: 2000));
      Navigator.pushNamed(context, 'login');
  }
}
