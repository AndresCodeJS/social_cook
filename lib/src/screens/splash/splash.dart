import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:social_cook/src/screens/splash/splash_controller.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  final _controller = SplashController(Permission.locationWhenInUse);

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _controller.checkPermission();
    });
    _controller.addListener(() { 

      if(_controller.routeName != null){
        Navigator.pushReplacementNamed(context, _controller.routeName!);
      }

    });
  }
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}