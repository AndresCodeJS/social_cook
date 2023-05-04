import 'dart:async';

import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../ui/routes/routes.dart';
import 'request_permission_controller.dart';

class RequestPermisionScreen extends StatefulWidget {
  const RequestPermisionScreen({super.key});

  @override
  State<RequestPermisionScreen> createState() => _RequestPermisionScreenState();
}

class _RequestPermisionScreenState extends State<RequestPermisionScreen>
    with WidgetsBindingObserver {
  final _controller = RequestPermissionController(Permission.locationWhenInUse);

  late StreamSubscription _suscription;

  bool _fromSettings = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    _suscription = _controller.onStatusChanged.listen((status) {
      switch (status) {
        case PermissionStatus.granted:
          Navigator.pushReplacementNamed(context, Routes.MAP);
          break;

        case PermissionStatus.permanentlyDenied:
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: const Text("INFO"),
                    content: const Text(
                        "Para un correcto funcionamiento es necesario que entres a ajustes permitas el acceso a la ubicación del dispositivo "),
                    actions: [
                      TextButton(
                          onPressed: () async {
                            _fromSettings = await openAppSettings();
                            Navigator.pop(context);
                          },
                          child: const Text("Ir a Ajustes")),
                      TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text("Cancelar"))
                    ],
                  ));

          break;
      }
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed && _fromSettings) {
      final status = await _controller.check();
      if (status == PermissionStatus.granted ) {
        Navigator.pushReplacementNamed(context, Routes.MAP);
      }

      _fromSettings = false;
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _suscription.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        height: double.infinity,
        width: double.infinity,
        alignment: Alignment.center,
        child: ElevatedButton(
          child: const Text("Allow"),
          onPressed: () {
            _controller.request();
          },
        ),
      ),
    ));
  }
}
