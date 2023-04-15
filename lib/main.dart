import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeData theme = ThemeData();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme.copyWith(
        colorScheme: theme.colorScheme.copyWith(
          primary: Colors.cyan,
          secondary: Colors.white,
        ),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {

  //Animacion    
  late final AnimationController _controller =
      AnimationController(duration: const Duration(seconds: 1), vsync: this);

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool _loading = false;
  bool _onKeyboardShows = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: <Widget>[
        Container(
          /* height: MediaQuery.of(context).size.height*0.7, */
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Color.fromARGB(255, 146, 201, 209),
            Color.fromARGB(255, 11, 180, 196)
          ])),
          child: Column(
            /* mainAxisSize: MainAxisSize.min, */

            children: <Widget>[
              Image.asset(
                "assets/sombrero.png",
                color: Colors.white,
                height: 200,
              ),
              const Text("Social Cook",
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: "Gloria Hallelujah",
                      fontSize: 40))
            ],
          ),
        ),
        Center(
          child: SingleChildScrollView(
            child: Card(
              margin: EdgeInsets.only(
                  top: _onKeyboardShows ? 100 : 200,
                  right: 20,
                  left: 20,
                  bottom: 40),
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 40, left: 40, top: 20, bottom: 40),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Usuario"),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      decoration:
                          const InputDecoration(labelText: "Contraseña"),
                      obscureText: true,
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(double.infinity, 60)),
                        onPressed: () {
                          /* _login(context); */
                          _moveLoginCard(context);
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            !_loading
                                ? const Text(
                                    "Iniciar Sesión",
                                  )
                                : const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  ),
                          ],
                        )),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      children: const <Widget>[Text("No tienes cuenta?")],
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    ));
  }

  void _login(BuildContext context) {
    if (!_loading) {
      setState(() {
        _loading = true;
      });
    }
  }

  void _moveLoginCard(BuildContext context) {
    setState(() {
      _onKeyboardShows = true;
    });
  }
}
