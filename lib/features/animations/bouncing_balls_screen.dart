import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class Ball {
  Offset position;
  Offset velocity;
  final Color color;
  DateTime lastBounceTime;

  Ball({required this.position, required this.velocity, required this.color}) : lastBounceTime = DateTime.now();
}

class BouncingBallsScreen extends HookWidget {
  const BouncingBallsScreen({super.key});

  static const String route = '/bouncing_balls';

  @override
  Widget build(BuildContext context) {
    final balls = useState<List<Ball>>([]);
    final allowNewBalls = useState<bool>(true);
    final allowAcceleration = useState<bool>(false);
    final initialSpeed = useState<double>(5.0);
    final isPaused = useState<bool>(false);
    final animationStarted = useState<bool>(false);
    final ballDiameter = 15.0;

    void startAnimation() {
      balls.value = [
        Ball(
          position: const Offset(40, 40),
          velocity: Offset(initialSpeed.value, initialSpeed.value),
          color: Colors.red,
        ),
      ];
      animationStarted.value = true;
      isPaused.value = false;
    }

    void togglePause() {
      isPaused.value = !isPaused.value;
    }

    void resetAnimation() {
      balls.value = [
        Ball(
          position: const Offset(40, 40),
          velocity: Offset(initialSpeed.value, initialSpeed.value),
          color: Colors.red,
        ),
      ];
      isPaused.value = false;
    }

    void addNewBall(Offset position) {
      final random = Random();
      final newVelocity = Offset(
        random.nextDouble() * 20 - 10,
        random.nextDouble() * 20 - 10,
      );
      final newColor = Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(1.0);
      balls.value = List.from(balls.value)..add(Ball(position: position, velocity: newVelocity, color: newColor));
    }

    void updateBalls(Rect box) {
      for (var i = 0; i < balls.value.length; i++) {
        var ball = balls.value[i];
        final currentTime = DateTime.now();

        ball.position += ball.velocity;

        if (ball.position.dx - ballDiameter / 2 <= box.left || ball.position.dx + ballDiameter / 2 >= box.right) {
          ball.velocity =
              Offset(allowAcceleration.value ? -ball.velocity.dx * 1.1 : -ball.velocity.dx, ball.velocity.dy);
          ball.position = Offset(
            ball.position.dx.clamp(box.left + ballDiameter / 2, box.right - ballDiameter / 2),
            ball.position.dy,
          );

          if (allowNewBalls.value && currentTime.difference(ball.lastBounceTime) > const Duration(milliseconds: 300)) {
            ball.lastBounceTime = currentTime;
            addNewBall(ball.position);
          }
        }

        if (ball.position.dy - ballDiameter / 2 <= box.top || ball.position.dy + ballDiameter / 2 >= box.bottom) {
          ball.velocity =
              Offset(ball.velocity.dx, allowAcceleration.value ? -ball.velocity.dy * 1.1 : -ball.velocity.dy);
          ball.position = Offset(
            ball.position.dx,
            ball.position.dy.clamp(box.top + ballDiameter / 2, box.bottom - ballDiameter / 2),
          );

          if (allowNewBalls.value && currentTime.difference(ball.lastBounceTime) > const Duration(milliseconds: 300)) {
            ball.lastBounceTime = currentTime;
            addNewBall(ball.position);
          }
        }
      }
    }

    useEffect(() {
      if (!animationStarted.value) return null;

      final timer = Timer.periodic(const Duration(milliseconds: 16), (_) {
        if (!isPaused.value) {
          final box =
              Rect.fromLTRB(20, 20, MediaQuery.of(context).size.width * 0.95, MediaQuery.of(context).size.height * 0.6);
          updateBalls(box);
          balls.value = List.from(balls.value);
        }
      });
      return timer.cancel;
    }, [animationStarted.value, isPaused.value]);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Bouncing Balls'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => SettingsSheet(
                  initialSpeed: initialSpeed,
                  allowNewBalls: allowNewBalls,
                  allowAcceleration: allowAcceleration,
                  onApply: resetAnimation,
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (animationStarted.value)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Number of Balls: ${balls.value.length}', style: const TextStyle(fontSize: 16)),
            ),
          Expanded(
            child: Center(
              child: Stack(
                children: [
                  if (animationStarted.value)
                    for (var ball in balls.value)
                      Positioned(
                        left: ball.position.dx - ballDiameter / 2,
                        top: ball.position.dy - ballDiameter / 2,
                        child: Container(
                          width: ballDiameter,
                          height: ballDiameter,
                          decoration: BoxDecoration(color: ball.color, shape: BoxShape.circle),
                        ),
                      ),
                  if (!animationStarted.value)
                    Center(
                      child: IconButton(
                        icon: const Icon(Icons.play_circle_fill),
                        iconSize: 100,
                        color: Colors.blue,
                        onPressed: startAnimation,
                      ),
                    ),
                ],
              ),
            ),
          ),
          if (animationStarted.value)
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    icon: Icon(isPaused.value ? Icons.play_arrow : Icons.pause),
                    iconSize: 50,
                    onPressed: togglePause,
                  ),
                  IconButton(
                    icon: const Icon(Icons.refresh),
                    iconSize: 50,
                    onPressed: resetAnimation,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class SettingsSheet extends HookWidget {
  final ValueNotifier<double> initialSpeed;
  final ValueNotifier<bool> allowNewBalls;
  final ValueNotifier<bool> allowAcceleration;
  final void Function() onApply;

  const SettingsSheet({
    required this.initialSpeed,
    required this.allowNewBalls,
    required this.allowAcceleration,
    required this.onApply,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final localSpeed = useState(initialSpeed.value);
    final currAllowNewBalls = useState(allowNewBalls.value);
    final currAllowAcceleration = useState(allowAcceleration.value);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Settings', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Initial Speed'),
              Slider(
                min: 1.0,
                max: 10.0,
                value: localSpeed.value,
                onChanged: (val) => localSpeed.value = val,
              ),
            ],
          ),
          SwitchListTile(
            title: const Text('Spawn new balls on bounce'),
            value: currAllowNewBalls.value,
            onChanged: (val) => currAllowNewBalls.value = val,
          ),
          SwitchListTile(
            title: const Text('Increase speed on bounce'),
            value: currAllowAcceleration.value,
            onChanged: (val) => currAllowAcceleration.value = val,
          ),
          ElevatedButton(
            onPressed: () {
              initialSpeed.value = localSpeed.value;
              allowNewBalls.value = currAllowNewBalls.value;
              allowAcceleration.value = currAllowAcceleration.value;
              onApply.call();
              Navigator.pop(context);
            },
            child: const Text('Save & Apply'),
          ),
        ],
      ),
    );
  }
}
