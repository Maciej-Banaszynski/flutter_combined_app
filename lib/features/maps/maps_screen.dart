import 'package:flutter/material.dart';

import '../../common/extensions/build_context_extensions.dart';
import '../../common/widgets/app_scaffold/app_scaffold.dart';
import 'apple_maps/apple_maps_view.dart';
import 'google_maps/google_maps_view.dart';

class MapsScreen extends StatelessWidget {
  const MapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      screenTitle: context.localizations.maps_dashboard_title,
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          AppleMapsView(),
          GoogleMapsView(),
        ],
      ),
    );
  }
}
