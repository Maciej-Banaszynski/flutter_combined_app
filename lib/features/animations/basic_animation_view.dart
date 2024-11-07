import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../common/widgets/app_scaffold/app_scaffold.dart';

class BasicAnimationView extends HookWidget {
  const BasicAnimationView({super.key});

  static const String route = '/basic_animation_view';

  @override
  Widget build(BuildContext context) {
    // Linear Animation
    final linearController = useAnimationController(duration: const Duration(seconds: 3))..repeat();
    final linearAnimation = Tween(begin: 0.0, end: 1.0).animate(linearController);

    // Ease-In Animation
    final easeInController = useAnimationController(duration: const Duration(seconds: 3))..repeat();
    final easeInAnimation = CurvedAnimation(parent: easeInController, curve: Curves.easeIn);

    // Bounce Animation
    final bounceController = useAnimationController(duration: const Duration(seconds: 3))..repeat();
    final bounceAnimation = CurvedAnimation(parent: bounceController, curve: Curves.bounceInOut);

    // Scale Animation
    final scaleController = useAnimationController(duration: const Duration(seconds: 3))..repeat();
    final scaleAnimation = Tween(begin: 0.5, end: 1.5).animate(scaleController);

    // Rotation Animation
    final rotationController = useAnimationController(duration: const Duration(seconds: 3))..repeat();
    final rotationAnimation = Tween(begin: 0.0, end: 1.0).animate(rotationController);

    return AppScaffold(
      screenTitle: 'Basic Animations',
      child: SingleChildScrollView(
        child: Column(
          children: [
            _buildAnimationRow("Linear Animation", linearAnimation, linearController),
            _buildAnimationRow("Ease-in Animation", easeInAnimation, easeInController),
            _buildAnimationRow("Bounce Animation", bounceAnimation, bounceController),
            _buildAnimationRow("Scale Animation", scaleAnimation, scaleController, isScale: true),
            _buildAnimationRow("Rotation Animation", rotationAnimation, rotationController, isRotation: true),
          ],
        ),
      ),
    );
  }

  Widget _buildAnimationRow(String label, Animation<double> animation, AnimationController controller,
      {bool isScale = false, bool isRotation = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 18)),
          AnimatedBuilder(
            animation: controller,
            builder: (context, child) {
              // Animation metric values
              double progress = animation.value;
              double frameRate = View.of(context).devicePixelRatio * 60;
              int duration = controller.duration!.inMilliseconds;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildMetric("Progress:", "${(progress * 100).toStringAsFixed(1)}%"),
                  _buildMetric("Frame Rate:", "${frameRate.toInt()} FPS"),
                  _buildMetric("Duration:", "$duration ms"),
                  SizedBox(
                    width: 100,
                    child: LinearProgressIndicator(value: progress),
                  ),
                  const SizedBox(height: 10),
                  _buildAnimatedBox(progress, isScale: isScale, isRotation: isRotation),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMetric(String label, String value) {
    return Text(
      "$label $value",
      style: const TextStyle(fontSize: 16),
    );
  }

  Widget _buildAnimatedBox(double animationValue, {bool isScale = false, bool isRotation = false}) {
    return Container(
      width: 50,
      height: 50,
      alignment: Alignment.center,
      child: Transform.scale(
        scale: isScale ? animationValue : 1.0,
        child: Transform.rotate(
          angle: isRotation ? animationValue * 6.28 : 0.0, // 2 * pi radians for full rotation
          child: Container(
            width: 40,
            height: 40,
            color: Colors.blueAccent,
            child: isRotation ? const Icon(Icons.refresh, color: Colors.white) : null,
          ),
        ),
      ),
    );
  }
}
