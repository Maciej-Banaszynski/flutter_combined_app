import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

extension Localization on BuildContext {
  AppLocalizations get localizations => AppLocalizations.of(this)!;

  void showSuccessSnackBar({required String message}) {
    final snackBar = SnackBar(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      backgroundColor: Colors.green,
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }

  void showErrorSnackBar({required String message}) {
    final snackBar = SnackBar(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      backgroundColor: Colors.red,
      content: Text(message),
      behavior: SnackBarBehavior.floating,
    );

    ScaffoldMessenger.of(this).showSnackBar(snackBar);
  }
}
