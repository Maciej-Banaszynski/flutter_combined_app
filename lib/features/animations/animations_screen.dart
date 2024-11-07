import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../common/extensions/build_context_extensions.dart';
import '../../common/extensions/navigation_on_string/navigation_on_string.dart';
import '../../common/widgets/app_scaffold/app_scaffold.dart';
import 'basic_animation_view.dart';
import 'controlled_animated_screen.dart';
import 'hero_animations_view.dart';

class AnimationsScreen extends StatelessWidget {
  const AnimationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      screenTitle: context.localizations.animations_dashboard_title,
      child: Column(
        children: [
          _buildAnimationButton(
            title: 'Basic Multiple Animations',
            onTap: () => Modular.to.pushNamed(BasicAnimationView.route.relativePath),
          ),
          _buildAnimationButton(
            title: 'Controlled Animated Screen',
            onTap: () => Modular.to.pushNamed(ControlledAnimatedScreen.route.relativePath),
          ),
          _buildAnimationButton(
            title: 'Hero Animation Screen',
            onTap: () => Modular.to.pushNamed(HeroAnimationsScreen.route.relativePath),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimationButton({
    required String title,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: const Icon(Icons.animation_rounded, color: Colors.blueAccent),
        title: Text(title, style: const TextStyle(fontSize: 18)),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
