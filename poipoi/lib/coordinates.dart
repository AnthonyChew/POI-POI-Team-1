import 'package:google_maps_flutter/google_maps_flutter.dart';

class Coordinates {
  List<Marker> list = [
    const Marker(
        markerId: MarkerId('My Location'),
        position: LatLng(1.385000, 103.745000),
        infoWindow: InfoWindow(
            title: 'My Location'
        )
    ),
    const Marker(
        markerId: MarkerId('1'),
        position: LatLng(1.383500, 103.744000),
        infoWindow: InfoWindow(
            title: 'Location 1'
        )
    ),
    const Marker(
        markerId: MarkerId('2'),
        position: LatLng(1.384120, 103.746000),
        infoWindow: InfoWindow(
            title: 'Location 2'
        )
    ),
    const Marker(
        markerId: MarkerId('3'),
        position: LatLng(1.386100, 103.743010),
        infoWindow: InfoWindow(
            title: 'Location 3'
        )
    ),
  ];
}