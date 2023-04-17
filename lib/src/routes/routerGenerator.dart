import 'package:flutter/material.dart';
import 'package:social_cook/main.dart';
import 'package:social_cook/src/screens/homePage.dart';

import '../models/User.dart';
import '../screens/login.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
 

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            builder: (context) => const MyLoginPage(title: "Login"));
      case '/homePage':
            User loggedUser = settings.arguments as User ;
            return MaterialPageRoute(
            builder: (context) =>  HomePage());
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('ERROR'),
          centerTitle: true,
        ),
        body: const Center(
          child: Text('Page not found!'),
        ),
      );
    });
  }
}
