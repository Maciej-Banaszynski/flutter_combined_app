import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';

class AppleMapsView extends StatefulWidget {
  const AppleMapsView({super.key});

  @override
  State<AppleMapsView> createState() => _AppleMapsViewState();
}

class _AppleMapsViewState extends State<AppleMapsView> {
  AppleMapController? mapController;

  void _onMapCreated(AppleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AppleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: LatLng(0.0, 0.0),
        ),
      ),
    );
  }
}
