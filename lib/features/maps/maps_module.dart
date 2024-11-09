import 'package:flutter_modular/flutter_modular.dart';

import '../../app/app_route_paths.dart';
import 'apple_maps/apple_maps_view.dart';
import 'google_maps/google_maps_view.dart';
import 'maps_screen.dart';

class MapsModule extends Module {
  @override
  void routes(r) {
    r.child(
      AppRoutePaths.startPath,
      child: (context) => const MapsScreen(),
      transition: TransitionType.noTransition,
    );
    r.child(
      GoogleMapsView.route,
      child: (_) => GoogleMapsView(),
    );
    r.child(
      AppleMapView.route,
      child: (_) => const AppleMapView(),
    );
    super.routes(r);
  }
}
