import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:social_cook/src/ui/utils/map_style.dart';

class HomeController with ChangeNotifier {
  String _nombre = "";

  final Map<MarkerId, Marker> _markers = {};

  Set<Marker> get markers => _markers.values.toSet();

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(mapStyle);
  }

  onTap(LatLng position) {
    final markerId = MarkerId(_markers.length.toString());

    final marker = Marker(markerId: markerId, position: position);

    _markers[markerId] = marker;

    _nombre = "Andres";

    print("POSITION $position");

    notifyListeners();
  }
}
