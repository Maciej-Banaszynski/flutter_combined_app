import 'dart:math';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../data/models/user/user.dart';
import 'cubit/animation_comparison_cubit.dart';

class AnimationComparisonView extends HookWidget {
  const AnimationComparisonView({
    super.key,
  });

  AnimationComparisonCubit _cubit(BuildContext context) => context.read<AnimationComparisonCubit>();

  @override
  Widget build(BuildContext context) {
    final isAnimating = useState(false);
    final numElements = useState(5);
    final animationSpeed = useState(1);
    final isLoadingUsers = useState(false);
    final listOfUsers = useState<List<User>>([]);

    Future<void> loadUsers(BuildContext context, {required GeneratedUsersCount count}) async {
      isLoadingUsers.value = true;
      final String csvString = await rootBundle.loadString(count.filePath);

      final List<List<dynamic>> csvData = const CsvToListConverter().convert(csvString);

      csvData.skip(1).forEach(
        (row) {
          final user = User(
            id: 0,
            firstName: row[0] as String,
            lastName: row[1] as String,
            birthDate: DateTime.parse(row[2] as String),
            address: row[3] as String,
            phoneNumber: row[4] is int ? row[4].toString() : row[4] as String,
            position: row[5] as String,
            company: row[6] as String,
          );

          listOfUsers.value.add(user);
        },
      );
      isLoadingUsers.value = false;
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Animation Comparison')),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Number of Animations:"),
                      DropdownButton<int>(
                        value: numElements.value,
                        items: [5, 10, 20, 50, 100, 200, 500, 800, 1000]
                            .map((e) => DropdownMenuItem<int>(
                                  value: e,
                                  child: Text(e.toString()),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            numElements.value = value;
                          }
                        },
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      const Text("Animation Speed:"),
                      DropdownButton<int>(
                        value: animationSpeed.value,
                        items: [20, 200, 1000]
                            .map((e) => DropdownMenuItem<int>(
                                  value: e,
                                  child: Text(e.toString()),
                                ))
                            .toList(),
                        onChanged: (value) {
                          if (value != null) {
                            animationSpeed.value = value;
                          }
                        },
                      ),
                      Text("${animationSpeed.value}"),
                    ],
                  ),
                  SwitchListTile(
                    title: const Text("Run Animations"),
                    value: isAnimating.value,
                    onChanged: (value) {
                      isAnimating.value = value;
                    },
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Loaded Users: ${listOfUsers.value.length}"),
                      if (isLoadingUsers.value)
                        const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      ...GeneratedUsersCount.values.map((count) {
                        return Expanded(
                          child: ElevatedButton(
                            onPressed: isLoadingUsers.value ? null : () => loadUsers(context, count: count),
                            child: Text("Load\n${count.displayName}", textAlign: TextAlign.center),
                          ),
                        );
                      }),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: isLoadingUsers.value ? null : () => listOfUsers.value = [],
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                          child: const Text(
                            "Clear",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 60),
            SizedBox(
              height: 500,
              child: Stack(
                alignment: Alignment.center,
                children: List.generate(
                  numElements.value,
                  (index) => ExpensiveAnimatedCircle(
                    isAnimating: isAnimating.value,
                    animationSpeed: animationSpeed.value.toDouble(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ExpensiveAnimatedCircle extends HookWidget {
  const ExpensiveAnimatedCircle({
    super.key,
    required this.isAnimating,
    required this.animationSpeed,
  });

  final bool isAnimating;
  final double animationSpeed;

  @override
  Widget build(BuildContext context) {
    final maxMilliseconds = max(((2.0 + Random().nextDouble() * (10.0 - 2.0)) / animationSpeed * 1000).round(), 1);
    final Duration duration = Duration(milliseconds: maxMilliseconds);
    final animationController = useAnimationController(duration: duration);
    final randomX = useMemoized(() => Random().nextDouble() * 300 - 150, []);
    final randomY = useMemoized(() => Random().nextDouble() * 600 - 300, []);
    final randomColor = useMemoized(
      () => Color.fromRGBO(
        (Random().nextDouble() * 255).toInt(),
        (Random().nextDouble() * 255).toInt(),
        (Random().nextDouble() * 255).toInt(),
        1,
      ),
      [],
    );

    useEffect(() {
      if (isAnimating) {
        animationController.repeat(reverse: true);
      } else {
        animationController.stop();
        animationController.reset();
      }
      return null;
    }, [isAnimating, animationSpeed]);

    final animation = Tween<Offset>(
      begin: Offset.zero,
      end: Offset(randomX / MediaQuery.of(context).size.width, randomY / MediaQuery.of(context).size.height),
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Curves.easeInOut,
      ),
    );

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(
            animation.value.dx * MediaQuery.of(context).size.width,
            animation.value.dy * MediaQuery.of(context).size.height,
          ),
          child: Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: randomColor,
              shape: BoxShape.circle,
            ),
          ),
        );
      },
    );
  }
}
