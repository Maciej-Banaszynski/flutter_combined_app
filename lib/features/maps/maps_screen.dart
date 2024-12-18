import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../common/extensions/build_context_extensions.dart';
import '../../common/extensions/navigation_on_string/navigation_on_string.dart';
import '../../common/widgets/app_scaffold/app_scaffold.dart';
import 'apple_maps/apple_maps_view.dart';
import 'google_maps/google_maps_view.dart';

class MapsScreen extends StatelessWidget {
  const MapsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      screenTitle: context.localizations.maps_dashboard_title,
      child: Column(
        children: [
          _buildMapsButton(
            icon: Icons.map_sharp,
            title: 'Google Maps View',
            onTap: () => Modular.to.pushNamed(GoogleMapsView.route.relativePath),
          ),
          _buildMapsButton(
            icon: Icons.map_sharp,
            title: 'Apple Maps View',
            onTap: () => Modular.to.pushNamed(AppleMapView.route.relativePath),
          ),
        ],
      ),
    );
  }

  Widget _buildMapsButton({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: Icon(icon, color: Colors.blueAccent),
        title: Text(title, style: const TextStyle(fontSize: 18)),
        trailing: const Icon(Icons.chevron_right, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }
}
