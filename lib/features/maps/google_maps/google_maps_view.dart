import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../../common/widgets/app_scaffold/app_scaffold.dart';
import '../../../data/services/location_service/location_service.dart';

class GoogleMapsView extends HookWidget {
  GoogleMapsView({super.key});

  static const String route = '/google_maps_view';

  final LocationService locationService = LocationService();

  @override
  Widget build(BuildContext context) {
    final mapController = useState<GoogleMapController?>(null);
    final currentLocation = useState<Position?>(null);
    final markers = useState<Set<Marker>>({});
    final polylines = useState<Set<Polyline>>({});

    useEffect(() {
      locationService.handleLocationPermission();
      locationService.getCurrentPosition().then((position) {
        currentLocation.value = position;
        mapController.value?.animateCamera(CameraUpdate.newLatLng(
          LatLng(position.latitude, position.longitude),
        ));
      });

      final positionStream = locationService.getPositionStream().listen((position) {
        currentLocation.value = position;
        mapController.value?.animateCamera(CameraUpdate.newLatLng(
          LatLng(position.latitude, position.longitude),
        ));
      });

      return positionStream.cancel;
    }, []);

    return AppScaffold(
      screenTitle: 'Google Map',
      child: GoogleMap(
        onMapCreated: (controller) => mapController.value = controller,
        initialCameraPosition: CameraPosition(
          target: LatLng(
            currentLocation.value?.latitude ?? 0.0,
            currentLocation.value?.longitude ?? 0.0,
          ),
          zoom: 14.0,
        ),
        myLocationEnabled: true,
        // markers: markers.value,
        // polylines: polylines.value,
      ),
    );
  }
}

Future<List<LatLng>> getRouteCoordinates(LatLng start, LatLng end) async {
  final url = Uri.parse(
    'https://maps.googleapis.com/maps/api/directions/json'
    '?origin=${start.latitude},${start.longitude}'
    '&destination=${end.latitude},${end.longitude}'
    '&key=YOUR_GOOGLE_MAPS_API_KEY',
  );

  final response = await http.get(url);
  final data = json.decode(response.body);

  if (data['routes'].isEmpty) return [];

  final polyline = data['routes'][0]['overview_polyline']['points'];
  return decodePolyline(polyline);
}

List<LatLng> decodePolyline(String polyline) {
  List<LatLng> points = [];
  int index = 0, len = polyline.length;
  int lat = 0, lng = 0;

  while (index < len) {
    int b, shift = 0, result = 0;
    do {
      b = polyline.codeUnitAt(index++) - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } while (b >= 0x20);
    int dlat = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
    lat += dlat;

    shift = 0;
    result = 0;
    do {
      b = polyline.codeUnitAt(index++) - 63;
      result |= (b & 0x1f) << shift;
      shift += 5;
    } while (b >= 0x20);
    int dlng = (result & 1) != 0 ? ~(result >> 1) : (result >> 1);
    lng += dlng;

    points.add(LatLng(lat / 1E5, lng / 1E5));
  }
  return points;
}

// Future<void> setRoute() async {
//   final routePoints = await getRouteCoordinates(
//     LatLng(START_LATITUDE, START_LONGITUDE),
//     LatLng(END_LATITUDE, END_LONGITUDE),
//   );
//   polylines.value = {
//     Polyline(
//       polylineId: PolylineId('route'),
//       points: routePoints,
//       color: Colors.blue,
//       width: 5,
//     ),
//   };
// }
