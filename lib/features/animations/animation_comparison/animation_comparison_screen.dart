import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'animation_comparison_view.dart';
import 'cubit/animation_comparison_cubit.dart';

class AnimationComparisonScreen extends StatelessWidget {
  const AnimationComparisonScreen({super.key});

  static const String route = '/animation_comparison';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => Modular.get<AnimationComparisonCubit>(),
      child: const AnimationComparisonView(),
    );
  }
}
