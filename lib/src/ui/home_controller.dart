import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:social_cook/src/ui/utils/map_style.dart';

class HomeController with ChangeNotifier {
  String _nombre = "";

  final Map<MarkerId, Marker> _markers = {};

  Set<Marker> get markers => _markers.values.toSet();

  //Funcionalidad tap en marcadores
  final _markerController = StreamController<String>.broadcast();
  Stream<String> get onMarkerTap => _markerController.stream;

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(mapStyle);
  }

  onTap(LatLng position) {

    final id = _markers.length.toString();

    final markerId = MarkerId(id);

    final marker = Marker(markerId: markerId, position: position, onTap: (){

      _markerController.sink.add(id);
    });

    _markers[markerId] = marker;

    _nombre = "Andres";

    print("POSITION $position");

    notifyListeners();
  }

  @override
  void dispose() {
     //Funcionalidad tap en marcadores
    _markerController.close();
    super.dispose();
  }
}
