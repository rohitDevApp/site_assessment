import 'package:flutter/material.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:site_assessment/src/common_widgets/common.dart';
import '../../../../constants/constants.dart';

class SplashAnimatedScreen extends StatefulWidget {
  const SplashAnimatedScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashAnimatedScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _rotationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  double progress = 0.0;

  @override
  void initState() {
    super.initState();

    // Fade In-Out Animation
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _fadeAnimation =
        Tween<double>(begin: 0.5, end: 1.0).animate(_fadeController);

    // Scale (Pulse) Animation
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );

    // Rotation Animation
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Check Authentication after delay
    checkAuthentication();

    // Simulate progress loading
    Timer.periodic(Duration(milliseconds: 100), (timer) {
      if (mounted) {
        setState(() {
          progress += 0.02;
          if (progress >= 1.0) {
            timer.cancel();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _rotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50], // Soft background color
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Refined logo with rotation animation
                AnimatedBuilder(
                  animation: _rotationController,
                  builder: (_, child) {
                    return Transform.rotate(
                      angle: _rotationController.value * 6.28,
                      child: child,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(35),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.blueAccent, Colors.lightBlue],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent.withOpacity(0.8),
                          blurRadius: 40,
                          spreadRadius: 10,
                          offset: Offset(5, 5),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.apartment,
                      size: 90,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizeBox(30),
                // Animated Text (Slide up effect)
                AnimatedOpacity(
                  opacity: _fadeController.value,
                  duration: Duration(milliseconds: 1200),
                  child: const Text(
                    "Site Assessment App",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                      letterSpacing: 1.5,
                      fontFamily: 'Roboto',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Streamline your site evaluations with cutting-edge tools.",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.blueGrey,
                    letterSpacing: 1.2,
                    fontFamily: 'Roboto',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                // Progress Bar instead of circular loading spinner
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void checkAuthentication() async {
    await Future.delayed(Duration(milliseconds: 2000)); // Simulate splash delay

    var prefs = await SharedPreferences.getInstance();
    var isLogin = prefs.getBool(KEYS.isLogin) ?? false;

    if (isLogin) {
      Navigator.pushReplacementNamed(context, ROUTES.dashboard);
    } else {
      Navigator.pushReplacementNamed(context, ROUTES.login);
    }
  }
}
