import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:social_cook/src/ui/utils/map_style.dart';
import 'package:social_cook/src/utils/asset_to_bytes.dart';
import 'package:social_cook/src/utils/generate_marker.dart';

class HomeController with ChangeNotifier {
  String _nombre = "";

  final Map<MarkerId, Marker> _markers = {};

  Set<Marker> get markers => _markers.values.toSet();

  //Funcionalidad tap en marcadores
  final _markerController = StreamController<String>.broadcast();
  Stream<String> get onMarkerTap => _markerController.stream;

  final _pikachuIcon = Completer<BitmapDescriptor>();

  bool _loading = true;
  bool get loading => _loading;

  late bool _gpsEnabled;
  bool get gpsEnabled => _gpsEnabled;

  StreamSubscription? _gpsSubscription;

  HomeController() {
    _init();
  }
  Future<void> _init() async {
    /*    assetToBytes('assets/pikachu.png',width: 100).then((value){
    final bitMap = BitmapDescriptor.fromBytes(value);

    _pikachuIcon.complete(bitMap);

    } */

    final value = await generateImage();

    final bitMap = BitmapDescriptor.fromBytes(value);

    _pikachuIcon.complete(bitMap);

    _loading = false;
    _gpsEnabled = await Geolocator.isLocationServiceEnabled();

    //Se usa para ecuchar cuando se active o desactive el gps
    _gpsSubscription = Geolocator.getServiceStatusStream().listen((status) {
      _gpsEnabled = status == ServiceStatus.enabled;
      notifyListeners();
    });

    notifyListeners();
  }

  Future<void> turnOnGps() => Geolocator.openLocationSettings();

  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(mapStyle);
  }

  onTap(LatLng position) async {
    final id = _markers.length.toString();
    final markerId = MarkerId(id);

    //Esto se usa si queremos crear el icono cada vez que pulsemos en el mapa
    /*   final icon = BitmapDescriptor.fromBytes(
      await assetToBytes('assets/pikachu.png',width: 100)
    ); */

    //Esto se usa para dejar el icono fijo desde un comienzo
    final icon = _pikachuIcon.future;

    final marker = Marker(
        markerId: markerId,
        position: position,

        /* draggable: true, */
        /* icon: BitmapDescriptor.defaultMarkerWithHue(57), */
        /*  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure), */
        icon: await icon,
        /* rotation: 45, */
        anchor: const Offset(0.5, 0.5),
        /*   onDragEnd: (newPosition) {
          print("La nueva posicion es $newPosition");
        }, */
        infoWindow: const InfoWindow(
          title: "San Francisco",
          snippet: "Ciudad de la niebla",
        ),
        onTap: () {
          _markerController.sink.add(id);
        });

    _markers[markerId] = marker;

    _nombre = "Andres";

    print("POSITION $position");

    notifyListeners();
  }

  @override
  void dispose() {
    _gpsSubscription?.cancel();
    //Funcionalidad tap en marcadores
    _markerController.close();
    super.dispose();
  }
}
