import 'package:flutter/material.dart';

import '../../common/widgets/app_scaffold/app_scaffold.dart';

class HeroAnimationsScreen extends StatelessWidget {
  const HeroAnimationsScreen({super.key});

  static const String route = '/hero_animation_view';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      screenTitle: 'Hero Animation Screen',
      child: Center(
        child: GestureDetector(
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const SecondScreen()),
          ),
          child: Hero(
            tag: 'hero-animation',
            child: Container(
              width: 100,
              height: 100,
              color: Colors.red,
              child: const Center(child: Text("Ekran 1")),
            ),
          ),
        ),
      ),
    );
  }
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Second Screen")),
      body: Center(
        child: Hero(
          tag: 'hero-animation',
          child: Container(
            width: 200,
            height: 200,
            color: Colors.red,
            child: const Center(child: Text("Ekran 2")),
          ),
        ),
      ),
    );
  }
}
