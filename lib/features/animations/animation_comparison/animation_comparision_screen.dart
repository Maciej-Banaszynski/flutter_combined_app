import 'dart:math';

import 'package:csv/csv.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_hooks/flutter_hooks.dart';

import '../../../data/models/user/user.dart';

class AnimationComparisonScreen extends HookWidget {
  const AnimationComparisonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isAnimating = useState(false);
    final numElements = useState(5);
    final animationSpeed = useState(1.0);
    final isLoading = useState(false);
    final loadedUsersCount = useState(0);

    Future<void> loadUsersFromCSV(GeneratedUsersCount count) async {
      isLoading.value = true;
      try {
        final String csvContent = await rootBundle.loadString(count.filePath);
        final rows = const CsvToListConverter().convert(csvContent);
        final users = rows.skip(1).map((row) {
          return User(
            id: 0,
            firstName: row[0].toString().trim(),
            lastName: row[1].toString().trim(),
            birthDate: DateTime.tryParse(row[2].toString().trim()) ?? DateTime.now(),
            address: row[3].toString().trim(),
            phoneNumber: row[4].toString().trim(),
            position: row[5].toString().trim(),
            company: row[6].toString().trim(),
          );
        }).toList();

        // Simulate some processing delay
        await Future.delayed(Duration(seconds: 2));

        loadedUsersCount.value = users.length;
      } catch (e) {
        print("Error loading CSV: $e");
      } finally {
        isLoading.value = false;
      }
    }

    return Scaffold(
      appBar: AppBar(title: Text("Expensive Animation")),
      body: Column(
        children: [
          // Settings Panel
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Number of Animations:"),
                    DropdownButton<int>(
                      value: numElements.value,
                      items: [5, 10, 20, 50, 100]
                          .map((count) => DropdownMenuItem(
                                value: count,
                                child: Text("$count"),
                              ))
                          .toList(),
                      onChanged: (value) {
                        if (value != null) numElements.value = value;
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Animation Speed:"),
                    Expanded(
                      child: Slider(
                        value: animationSpeed.value,
                        min: 0.1,
                        max: 5.0,
                        divisions: 50,
                        label: "${animationSpeed.value.toStringAsFixed(1)}x",
                        onChanged: (value) {
                          animationSpeed.value = value;
                        },
                      ),
                    ),
                  ],
                ),
                SwitchListTile(
                  title: Text("Run Animations"),
                  value: isAnimating.value,
                  onChanged: (value) {
                    isAnimating.value = value;
                  },
                ),
              ],
            ),
          ),

          // CSV Loading Buttons
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text("Loaded Users: ${loadedUsersCount.value}"),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: GeneratedUsersCount.values.map((count) {
                    return ElevatedButton(
                      onPressed: isLoading.value ? null : () => loadUsersFromCSV(count),
                      child: Text("Load ${count.displayName}"),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          // Animation Panel
          Expanded(
            child: Stack(
              children: List.generate(numElements.value, (index) {
                final random = Random();
                final animationController = useAnimationController(
                  duration: Duration(
                    milliseconds: ((2000 + random.nextInt(3000)) / animationSpeed.value).round(),
                  ),
                )..repeat(reverse: true);

                final offsetX = useState(random.nextDouble() * 300 - 150);
                final offsetY = useState(random.nextDouble() * 600 - 300);
                final randomColor = useMemoized(() => Color.fromARGB(
                      255,
                      random.nextInt(256),
                      random.nextInt(256),
                      random.nextInt(256),
                    ));

                useEffect(() {
                  if (isAnimating.value) {
                    animationController.repeat(reverse: true);
                  } else {
                    animationController.stop();
                  }
                  return animationController.dispose;
                }, [isAnimating.value, animationSpeed.value]);

                return AnimatedBuilder(
                  animation: animationController,
                  builder: (context, child) {
                    return Positioned(
                      left: MediaQuery.of(context).size.width / 2 +
                          offsetX.value +
                          sin(animationController.value * 2 * pi) * 50,
                      top: MediaQuery.of(context).size.height / 2 +
                          offsetY.value +
                          cos(animationController.value * 2 * pi) * 50,
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
              }),
            ),
          ),
        ],
      ),
    );
  }
}
