import 'package:apple_maps_flutter/apple_maps_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';

import '../../../common/widgets/app_scaffold/app_scaffold.dart';

class AppleMapView extends HookWidget {
  const AppleMapView({super.key});

  static const String route = '/apple_maps_view';

  @override
  Widget build(BuildContext context) {
    final mapController = useState<AppleMapController?>(null);
    final currentLocation = useState<Position?>(null);
    final markers = useState<Set<Annotation>>({});

    useEffect(() {
      _requestLocationPermission();
      _getCurrentLocation().then((position) {
        currentLocation.value = position;
        mapController.value?.moveCamera(
          CameraUpdate.newLatLng(
            LatLng(position.latitude, position.longitude),
          ),
        );
      });

      final positionStream = Geolocator.getPositionStream().listen((position) {
        currentLocation.value = position;
        mapController.value?.moveCamera(
          CameraUpdate.newLatLng(
            LatLng(position.latitude, position.longitude),
          ),
        );
      });

      return positionStream.cancel;
    }, []);

    return AppScaffold(
      screenTitle: 'Apple Map',
      child: AppleMap(
        onMapCreated: (controller) => mapController.value = controller,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            currentLocation.value?.latitude ?? 0.0,
            currentLocation.value?.longitude ?? 0.0,
          ),
          zoom: 14.0,
        ),
        annotations: markers.value,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        trackingMode: TrackingMode.follow,
      ),
    );
  }

  Future<Position> _getCurrentLocation() async {
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  Future<void> _requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }
  }

  // void addRoutePolyline(AppleMapController controller) {
  //   final polyline = Polyline(
  //     polylineId: PolylineId('route'),
  //     points: [
  //       LatLng(START_LATITUDE, START_LONGITUDE),
  //       LatLng(END_LATITUDE, END_LONGITUDE),
  //     ],
  //     color: Colors.blue,
  //     width: 5,
  //   );
  //
  //   controller.addPolyline(polyline);
  // }
}
