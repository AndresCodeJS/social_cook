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

class _RequestPermisionScreenState extends State<RequestPermisionScreen> {
  final _controller = RequestPermissionController(Permission.locationWhenInUse);
  late StreamSubscription _suscription;

  @override
  void initState() {
    super.initState();
    _suscription = _controller.onStatusChanged.listen((status) {
      if (status == PermissionStatus.granted) {
        Navigator.pushReplacementNamed(context, Routes.MAP);
      }
    });
  }

  @override
  void dispose() {
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
