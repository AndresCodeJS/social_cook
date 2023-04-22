import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'package:social_cook/src/providers/user.dart';
import 'package:social_cook/src/screens/detail.dart';

import 'package:social_cook/src/screens/homePage.dart';
import 'package:social_cook/src/screens/login.dart';
import 'package:social_cook/src/screens/register.dart';

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
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: theme.copyWith(
            colorScheme: theme.colorScheme.copyWith(
              primary: Colors.cyan,
              secondary: Colors.white,
            ),
          ),
          initialRoute: "/",
          routes: {
            /* "/": (context) => const MyLoginPage(
                  title: "Login",
                ),
            "/homePage": (context) => const HomePage(),
            "/register": (context) => const Register(), */
            "/": (context) => const Detail(),
          }),
    );
  }
}
