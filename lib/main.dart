import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:social_cook/src/providers/user.dart';
import 'package:social_cook/src/screens/detail.dart';

import 'package:social_cook/src/screens/homePage.dart';
import 'package:social_cook/src/screens/login.dart';
import 'package:social_cook/src/screens/map.dart';
import 'package:social_cook/src/screens/register.dart';
import 'package:social_cook/src/screens/request_permission/request_permission_screen.dart';
import 'package:social_cook/src/screens/splash/splash.dart';
import 'package:social_cook/src/ui/home_controller.dart';
import 'package:social_cook/src/ui/routes/routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeData theme = ThemeData();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ListenableProvider(create: (context) => User()),
        ListenableProvider(create: (context) {
          final controller = HomeController();
          //Funcionalidad tap en marcadores
          /* controller.onMarkerTap.listen((event) { }) */
          return controller;
        }),
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
              primary: Colors.cyan,
              secondary: Colors.white,
            ),
          ),
          initialRoute: Routes.PERMISSIONS,
          routes: {
            /*   "/": (context) => const MyLoginPage(
                  title: "Login",
                ),
            "/homePage": (context) => const HomePage(), */
            //  "/register": (context) => const Register(),
            Routes.SPLASH: (context) => const SplashScreen(),
            Routes.PERMISSIONS: (context) => const RequestPermisionScreen(),
            Routes.MAP: (context) => const MapScreen(),
          }),
    );
  }
}
