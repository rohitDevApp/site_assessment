import 'package:flutter/material.dart';

class LoadingAnimation extends StatefulWidget {
  const LoadingAnimation({super.key});

  @override
  LoadingAnimationState createState() => LoadingAnimationState();
}

class LoadingAnimationState extends State<LoadingAnimation>
    with TickerProviderStateMixin {
  late AnimationController _rotationController;
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    // Continuous Rotation Animation
    _rotationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Fade In-Out Animation
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _fadeAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(_fadeController);

    // Scale (Pulse) Animation
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _scaleAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _rotationController.dispose();
    _fadeController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AnimatedBuilder(
                  animation: _rotationController,
                  builder: (_, child) {
                    return Transform.rotate(
                      angle: _rotationController.value * 6.28,
                      child: child,
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(25),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent.withOpacity(0.6),
                          blurRadius: 25,
                          spreadRadius: 8,
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.sync,
                      size: 70,
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Checking...",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
