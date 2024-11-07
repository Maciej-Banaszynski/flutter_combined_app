import 'dart:math';

class ChartDataPoint {
  final double x;
  final double y;

  ChartDataPoint(this.x, this.y);
}

List<ChartDataPoint> generateRandomData(int count) {
  final random = Random();
  return List.generate(count, (index) => ChartDataPoint(index.toDouble(), random.nextDouble() * 10));
}
