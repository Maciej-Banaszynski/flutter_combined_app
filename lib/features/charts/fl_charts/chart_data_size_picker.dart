import 'package:flutter/material.dart';

import '../../../data/models/chart_data_point.dart';

class ChartDataSizePicker extends StatelessWidget {
  const ChartDataSizePicker({
    super.key,
    required this.dataSize,
    required this.dataSizeValues,
    required this.onValueChanged,
  });

  final DataSize dataSize;
  final List<DataSize> dataSizeValues;
  final ValueChanged<DataSize> onValueChanged;

  @override
  Widget build(BuildContext context) {
    return ToggleButtons(
      isSelected: dataSizeValues.map((size) => size == dataSize).toList(),
      onPressed: (index) {
        final selectedSize = dataSizeValues[index];
        onValueChanged(selectedSize);
      },
      children: dataSizeValues
          .map((size) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Text(size.size.toString()),
              ))
          .toList(),
    );
  }
}
