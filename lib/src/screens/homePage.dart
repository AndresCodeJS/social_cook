
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_cook/src/providers/user.dart';



class HomePage extends StatefulWidget {


  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {

    final user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        leading: IconButton(icon: const Icon(Icons.arrow_back), onPressed: () => {Navigator.of(context).pop()},),
      ),
      body: Center(
        child: Row(
          children:  <Widget>[
            Text("Nombre de usuario: ${user.nombre} , y el apellido ${user.apellido}")
          ],
        ),
      ),
    );
  }
}