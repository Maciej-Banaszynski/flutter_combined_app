import 'dart:math';

class ChartDataPoint {
  final double x;
  final double y;

  ChartDataPoint(this.x, this.y);
}

class DataPoint {
  final DateTime x;
  final double y;

  DataPoint({required this.x, required this.y});
}

List<ChartDataPoint> generateRandomData(int count) {
  final random = Random();
  return List.generate(count, (index) => ChartDataPoint(index.toDouble(), random.nextDouble() * 10));
}

class ChartsManager {
  static List<DataPoint> generateChartData({
    required DataSize dataSize,
    Duration component = const Duration(days: 1),
  }) {
    final valueRange = Range(0, 100);
    final currentDate = DateTime.now();
    final random = Random();

    return List.generate(dataSize.size, (index) {
      final date = currentDate.subtract(component * index);
      final value = valueRange.randomValue(random);
      if (!value.isFinite) {
        return null;
      }
      return DataPoint(x: date, y: value);
    }).whereType<DataPoint>().toList();
  }
}

enum DataSize {
  three(3),
  five(5),
  eight(8),
  ten(10),
  fifty(50),
  hundred(100),
  oneThousand(1000),
  tenThousand(10000),
  oneHundredThousand(100000);

  final int size;
  const DataSize(this.size);

  static List<DataSize> lineChartValues = [
    ten,
    fifty,
    hundred,
    oneThousand,
    tenThousand,
    oneHundredThousand,
  ];

  static List<DataSize> barChartValues = [
    three,
    five,
    eight,
    ten,
    fifty,
    hundred,
  ];
}

enum ChartType {
  single,
  multi;

  String get lineTitle {
    switch (this) {
      case ChartType.single:
        return "Single Line Chart";
      case ChartType.multi:
        return "Multi Line Chart";
    }
  }

  String get barTitle {
    switch (this) {
      case ChartType.single:
        return "Single Bar Chart";
      case ChartType.multi:
        return "Multi Bar Chart";
    }
  }
}

class Range {
  final double min;
  final double max;

  Range(this.min, this.max);

  double randomValue(Random random) => random.nextDouble() * (max - min) + min;
}
