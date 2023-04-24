import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  final _initialCameraPosition = const CameraPosition(target: LatLng(10.0175672,-69.2689193), zoom: 50);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        /* scrollGesturesEnabled: false, */
        zoomGesturesEnabled: false,
        zoomControlsEnabled: false,
        compassEnabled: false,
      )
    );
  }
}