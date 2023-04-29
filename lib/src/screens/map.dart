import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../ui/home_controller.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {

  final _initialCameraPosition = const CameraPosition(target: LatLng(10.0175672,-69.2689193), zoom: 50);

  /* final _controller = HomeController(); */



  

  @override
  Widget build(BuildContext context) {

     final controller = Provider.of<HomeController>(context);

     controller.onMarkerTap.listen((String id) {
      print("El marcador seleccionado es : $id");
     },);

    return Scaffold(
      appBar: AppBar(),
      body: Consumer<HomeController>(
        builder: (_,controller,child) => GoogleMap(
          initialCameraPosition: _initialCameraPosition,
          /* onMapCreated: _controller.onMapCreated, */
          /* scrollGesturesEnabled: false, */
         /*  zoomGesturesEnabled: false, */
         
          zoomControlsEnabled: false,
          compassEnabled: false,
          onTap: controller.onTap,
          markers: controller.markers
        ),
      )
    );
  }
}