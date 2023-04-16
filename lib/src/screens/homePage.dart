
import 'package:flutter/material.dart';

import '../models/User.dart';

class HomePage extends StatefulWidget {


  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: () => {Navigator.of(context).pop()},),
      ),
      body: Center(
        child: Row(
          children: const <Widget>[
            Text("HOME PAGE")
          ],
        ),
      ),
    );
  }
}