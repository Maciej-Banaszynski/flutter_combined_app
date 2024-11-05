import 'package:flutter/material.dart';

import '../../widgets/app_snack_bar/app_snack_bar.dart';

extension SnackBarExtension on BuildContext {
  void showTitledSnackBar({required String title}) {
    clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(
      AppSnackBar(title: title),
    );
  }

  void showSomethingWentWrongSnackBar() {
    clearSnackBars();
    ScaffoldMessenger.of(this).showSnackBar(
      AppSnackBar(),
    );
  }

  void clearSnackBars() {
    ScaffoldMessenger.of(this).clearSnackBars();
  }
}
