import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../extensions/app_snack_bar_on_context/app_snack_bar_on_context.dart';
import '../../extensions/build_context_extensions.dart';

class AppSnackBar extends SnackBar {
  AppSnackBar({
    super.key,
    String? title,
    Duration? duration,
  }) : super(
          duration: duration ?? const Duration(seconds: 4),
          content: AppSnackBarBody(title: title),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 2.h),
        );
}

class AppSnackBarBody extends StatelessWidget {
  const AppSnackBarBody({super.key, this.title});

  final String? title;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(title ?? context.localizations.app_something_went_wrong_title),
        const _AppSnackBarCloseButton(),
      ],
    );
  }
}

class _AppSnackBarCloseButton extends StatelessWidget {
  const _AppSnackBarCloseButton();

  @override
  Widget build(BuildContext context) {
    return IconButton(
      padding: EdgeInsets.zero,
      onPressed: context.clearSnackBars,
      icon: const Icon(Icons.close),
      style: IconButton.styleFrom(
        shape: const RoundedRectangleBorder(side: BorderSide.none),
      ),
    );
  }
}
