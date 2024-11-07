import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../common/widgets/app_scaffold/app_scaffold.dart';

class ControlledAnimatedScreen extends HookWidget {
  const ControlledAnimatedScreen({super.key});

  static const String route = '/controlled_animated_screen';

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(seconds: 2),
    );

    final animation = useMemoized(
      () => Tween<double>(begin: 0.0, end: 2.0).animate(
        CurvedAnimation(
          parent: animationController,
          curve: Curves.easeInOut,
        ),
      ),
    );

    useEffect(() {
      animationController.forward();
      return () => animationController.dispose();
    }, []);

    return AppScaffold(
      screenTitle: "Controlled Animated Screen",
      child: Center(
        child: FadeTransition(
          opacity: animation,
          child: ScaleTransition(
            scale: animation,
            child: GestureDetector(
              onTap: () => animationController.reverse(),
              child: Container(
                width: 100,
                height: 100,
                color: Colors.blue,
                child: const Center(child: Text("Tap me!")),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
