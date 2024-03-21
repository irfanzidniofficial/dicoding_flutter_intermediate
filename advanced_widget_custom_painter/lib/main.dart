import 'package:advanced_widget_custom_painter/animations/loader_animation.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController loaderController;
  late Animation<double> loaderAnimation;

  @override
  void initState() {
    super.initState();
    loaderController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    loaderAnimation = Tween(begin: 1.0, end: 1.4).animate(
      CurvedAnimation(
        parent: loaderController,
        curve: Curves.easeIn,
      ),
    );
    loaderController.repeat(reverse: true);
  }

  @override
  void dispose() {
    loaderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AnimatedBuilder(
            animation: loaderAnimation,
            builder: (context, child) {
              return Transform.rotate(
                angle: loaderController.status == AnimationStatus.forward
                    ? (math.pi * 2) * loaderController.value
                    : -(math.pi * 2) * loaderController.value,
                child: CustomPaint(
                  foregroundPainter: LoaderAnimation(
                    radiusRatio: loaderAnimation.value,
                  ),
                  size: const Size(300, 300),
                ),
              );
            }),
      ),
    );
  }
}
