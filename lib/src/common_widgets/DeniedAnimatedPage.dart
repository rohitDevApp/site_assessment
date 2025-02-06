import 'package:flutter/material.dart';
import 'package:site_assessment/src/common_widgets/CustomText.dart';

class DeniedAnimatedPage extends StatefulWidget {
  final String title;
  final String message;
  const DeniedAnimatedPage(this.title, this.message, {super.key});

  @override
  State<StatefulWidget> createState() => DeniedAnimatedPageState();
}

//modal State
class DeniedAnimatedPageState extends State<DeniedAnimatedPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _opacityAnimation;
  late Animation<double> _rotationAnimation;

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 2000))
          ..repeat(reverse: true);

    // Slide transition from bottom
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start below the screen
      end: Offset.zero, // End at the original position
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    //rotation Animation
    _rotationAnimation = Tween<double>(
      begin: 0.0,
      end: 2 * 3.1416,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.linear));

    // Opacity animation
    _opacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    ));

    // Start the animations when the screen is built
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _opacityAnimation,
          child: FadeTransition(
            opacity: _opacityAnimation,
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 14,
                  children: [
                    const Icon(
                      Icons.warning,
                      size: 50,
                      color: Colors.yellow,
                    ),
                    CustomText(widget.title, 24, FontWeight.bold, Colors.blue),
                    CustomText(
                      widget.message,
                      16,
                      FontWeight.normal,
                      Colors.black87,
                      alignment: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
