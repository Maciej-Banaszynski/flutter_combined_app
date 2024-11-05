import 'package:flutter/material.dart';

import '../un_focus_on_tap/un_focus_on_tap.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.child,
    this.bottomNavigationBar,
    this.endDrawer,
    this.topSafeArea = true,
    this.canPop = true,
    this.onPopInvokedWithResult,
    this.floatingActionButton,
    this.appBarActions,
    this.screenTitle,
  });

  final Widget? bottomNavigationBar;
  final Widget child;
  final Widget? endDrawer;
  final Widget? floatingActionButton;
  final List<Widget>? appBarActions;
  final String? screenTitle;

  final bool topSafeArea;
  final bool canPop;
  final void Function(bool, dynamic)? onPopInvokedWithResult;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: endDrawer,
      endDrawerEnableOpenDragGesture: true,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      appBar: screenTitle != null
          ? AppBar(
              title: Text(screenTitle!),
              actions: appBarActions,
            )
          : null,
      body: UnFocusOnTap(
        child: SafeArea(
          top: topSafeArea,
          child: PopScope(
            canPop: canPop,
            onPopInvokedWithResult: onPopInvokedWithResult,
            child: child,
          ),
        ),
      ),
    );
  }
}
