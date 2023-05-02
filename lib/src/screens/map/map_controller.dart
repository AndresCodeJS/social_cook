import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:social_cook/src/ui/utils/map_style.dart';
import 'package:social_cook/src/utils/asset_to_bytes.dart';
import 'package:social_cook/src/utils/generate_marker.dart';

import 'package:uuid/uuid.dart';
import 'package:uuid/uuid_util.dart';

class HomeController with ChangeNotifier {
  //Markers
  final Map<MarkerId, Marker> _markers = {};
  Set<Marker> get markers => _markers.values.toSet();
  //Polygons
  late String _polygonId;
  final Map<PolygonId, Polygon> _polygons = {};
  Set<Polygon> get polygons => _polygons.values.toSet();

  //Funcionalidad tap en marcadores
  final _markerController = StreamController<String>.broadcast();
  Stream<String> get onMarkerTap => _markerController.stream;

  final _pikachuIcon = Completer<BitmapDescriptor>();

  bool _loading = true;
  bool get loading => _loading;

  late bool _gpsEnabled;
  bool get gpsEnabled => _gpsEnabled;

  Position? _initialPosition;
  Position? get initialPosition => _initialPosition;

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
    _gpsSubscription =
        Geolocator.getServiceStatusStream().listen((status) async {
      _gpsEnabled = status == ServiceStatus.enabled;
      await getInitialPosition();
      notifyListeners();
    });

    await getInitialPosition();

    notifyListeners();
  }

  Future<void> getInitialPosition() async {
    if (_gpsEnabled && _initialPosition == null) {
      _initialPosition = await Geolocator.getCurrentPosition();
    }
  }

  Future<void> turnOnGps() => Geolocator.openLocationSettings();

  //Para darle un estilo al mapa
  void onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(mapStyle);
  }

  void newPolygonId(){
  _polygonId = const Uuid().v4();
  }

  onTap(LatLng position) async {






    /*  final id = _markers.length.toString();
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

    notifyListeners(); */
  }

  @override
  void dispose() {
    _gpsSubscription?.cancel();
    //Funcionalidad tap en marcadores
    _markerController.close();
    super.dispose();
  }
}
