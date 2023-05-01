import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'map_controller.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _initialCameraPosition =
      const CameraPosition(target: LatLng(10.0175672, -69.2689193), zoom: 50);

  /* final _controller = HomeController(); */

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomeController>(context);

    controller.onMarkerTap.listen(
      (String id) {
        print("El marcador seleccionado es : $id");
      },
    );

    return Scaffold(
      appBar: AppBar(),
      body: Selector<HomeController, bool>(
        selector: (_, controller) => controller.loading,
        builder: (context, loading, loadingWidget) {
          if (loading) {
            return loadingWidget!;
          }
          return Consumer<HomeController>(builder: (_, controller, child) {
            if (!controller.gpsEnabled) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Padding(
                      padding: EdgeInsets.all(40),
                      child: Text(
                        "Para usar esta aplicación necesitamos acceder a su ubicación, por favor active el gps",
                        textAlign: TextAlign.center,
                      ),
                    ),
                    ElevatedButton(
                        onPressed: () {
                          //otra forma de acceder al provider
                          /*  final controller = context.read<HomeController>(); */
                          controller.turnOnGps();
                        },
                        child: const Text("Activar el GPS"))
                  ],
                ),
              );
            }

            final initialPosition = LatLng(controller.initialPosition!.latitude,
                controller.initialPosition!.longitude);

            return GoogleMap(
                initialCameraPosition:
                    CameraPosition(target: initialPosition, zoom: 40),
                /* onMapCreated: _controller.onMapCreated, */
                /* scrollGesturesEnabled: false, */
                /*  zoomGesturesEnabled: false, */
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                zoomControlsEnabled: false,
                compassEnabled: false,
                onTap: controller.onTap,
                markers: controller.markers);
          });
        },
        child: const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
