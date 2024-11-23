import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

class MetricsManager with ChangeNotifier {
  static final MetricsManager _instance = MetricsManager._internal();
  factory MetricsManager() => _instance;

  MetricsManager._internal();

  static const MethodChannel _channel = MethodChannel('com.metricsmanager.channel');

  double batteryLevel = -1.0;
  String batteryState = "Unknown";
  double cpuUsage = -1.0;
  int fps = 0;

  Timer? _fpsTimer;
  final List<int> _frameTimes = [];

  Future<void> updateMetrics() async {
    try {
      final metrics = await _channel.invokeMethod<Map>('getMetrics');
      if (metrics != null) {
        batteryLevel = (metrics['batteryLevel'] as num?)?.toDouble() ?? -1.0;
        batteryState = metrics['batteryState'] as String? ?? "Unknown";
        cpuUsage = (metrics['cpuUsage'] as num?)?.toDouble() ?? -1.0;
        notifyListeners();
      }
    } catch (e) {
      debugPrint("Error fetching metrics: $e");
    }
  }

  void startFPSMonitoring() {
    _frameTimes.clear();
    _fpsTimer = Timer.periodic(const Duration(milliseconds: 100), (_) {
      final now = DateTime.now().millisecondsSinceEpoch;
      _frameTimes.add(now);
      _frameTimes.removeWhere((time) => now - time > 1000);
      fps = _frameTimes.length;
      notifyListeners();
    });
  }

  void stopFPSMonitoring() {
    _fpsTimer?.cancel();
    _fpsTimer = null;
  }

  Future<T?> trackAction<T>(String actionName, Future<T> Function() action) async {
    final startTime = DateTime.now();
    final csvFileName = "${actionName}_${_formatDate(startTime)}.csv";
    final csvFilePath = await _createCSVFile(csvFileName);

    List<List<String>> metricsData = [
      ["Time", "Battery Level", "Battery State", "CPU Usage (%)", "FPS"]
    ];

    final timer = Timer.periodic(const Duration(milliseconds: 100), (_) async {
      await updateMetrics();
      final row = _getCurrentMetrics(startTime);
      print(row);
      metricsData.add(row);
    });

    T? result;
    try {
      result = await action();
      final row = _getCurrentMetrics(startTime);
      metricsData.add(row);
    } finally {
      timer.cancel();
      await _saveMetricsToCSV(metricsData, csvFilePath);
    }

    return result;
  }

  List<String> _getCurrentMetrics(DateTime startTime) {
    final timestamp = DateTime.now().difference(startTime).inMilliseconds / 1000.0;
    return [
      timestamp.toStringAsFixed(2),
      batteryLevel.toStringAsFixed(2),
      batteryState,
      cpuUsage.toStringAsFixed(2),
      fps.toString()
    ];
  }

  Future<String> _createCSVFile(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = '${directory.path}/$fileName';
    await File(filePath).create();
    return filePath;
  }

  Future<void> _saveMetricsToCSV(List<List<String>> metrics, String filePath) async {
    final csvContent = metrics.map((e) => e.join(",")).join("\n");
    final file = File(filePath);
    await file.writeAsString(csvContent);
    debugPrint("Metrics saved to $filePath");
  }

  String _formatDate(DateTime date) {
    return "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}_${date.hour.toString().padLeft(2, '0')}-${date.minute.toString().padLeft(2, '0')}-${date.second.toString().padLeft(2, '0')}";
  }
}
