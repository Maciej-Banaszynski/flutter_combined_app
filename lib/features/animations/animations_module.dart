import 'package:flutter_modular/flutter_modular.dart';

import '../../app/app_route_paths.dart';
import 'animation_comparison/animation_comparision_screen.dart';
import 'animations_screen.dart';
import 'basic_animation_view.dart';
import 'bouncing_balls_screen.dart';
import 'controlled_animated_screen.dart';
import 'hero_animations_view.dart';

class AnimationsModule extends Module {
  @override
  void routes(r) {
    r.child(
      AppRoutePaths.startPath,
      child: (context) => const AnimationsScreen(),
      transition: TransitionType.noTransition,
    );
    r.child(
      AnimationComparisonScreen.route,
      child: (_) => const AnimationComparisonScreen(),
    );
    r.child(
      BasicAnimationView.route,
      child: (_) => const BasicAnimationView(),
    );
    r.child(
      ControlledAnimatedScreen.route,
      child: (_) => const ControlledAnimatedScreen(),
    );
    r.child(
      HeroAnimationsScreen.route,
      child: (_) => const HeroAnimationsScreen(),
    );
    r.child(
      BouncingBallsScreen.route,
      child: (_) => const BouncingBallsScreen(),
    );

    super.routes(r);
  }
}
