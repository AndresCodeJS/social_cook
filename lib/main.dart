import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'dart:async';

import 'package:social_cook/src/screens/homePage.dart';

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
      
      /* home: const MyLoginPage(title: 'Flutter Demo Home Page'), */
      routes: {
        "/": (BuildContext context) =>  const MyLoginPage(title: "Login",),
         "/homePage": (BuildContext context) =>  const HomePage(),

      }
    );
  }
}

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({super.key, required this.title});

  final String title;

  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  bool _loading = false;

  late String userName;
  late String password;
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Form(
          key: _formKey,
          child: Stack(
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                KeyboardVisibilityBuilder(builder: (context, isKeyboardVisible) {
                  return Column(
                    children: [
                      AnimatedSize(
                        curve: Curves.easeIn,
                        duration: const Duration(microseconds: 500),
                        child: Image.asset(
                          "assets/sombrero.png",
                          color: Colors.white,
                          height: isKeyboardVisible ? 150 : 200,
                        ),
                      ),
                      AnimatedOpacity(
                        opacity: isKeyboardVisible ? 0.0 : 1.0,
                        duration: const Duration(milliseconds: 500),
                        child: const Text("Social Cook",
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Gloria Hallelujah",
                                fontSize: 40)),
                      ),
                       
                    ],
                  );
                }),
                const SizedBox(
                  height: 100,
                ),
              ],
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                margin: const EdgeInsets.only(
                    top:  200,
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
                        onSaved: (value){
                          userName = value!;
                        },
                        validator: (value){
                          if(value!.isEmpty){
                            return "Llene este campo";
                          }
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        decoration:
                            const InputDecoration(labelText: "Contraseña"),
                        obscureText: true,
                         onSaved: (value){
                          password = value!;
                        },
                         validator: (value){
                          if(value!.isEmpty){
                            return "Llene este campo";
                          }
                        },
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(double.infinity, 60)),
                          onPressed: () {
                            _login(context);
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
        
                       const SizedBox(height: 40,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children:  <Widget>[
                              const Text("No tienes cuenta?"),
                              TextButton(onPressed: () => {}, child: const Text("Registrate"))
                            ],
                          )
                    ],
                  ),
                ),
              ),
            ),
          ),
              ],
            ),
        ));
  }

  void _login(BuildContext context) {
    if (!_loading) {
      setState(() {
        _loading = true;
      });
    }
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      print("Hola $userName , $password");
      Navigator.of(context).pushNamed("/homePage");
      _loading = false;
    }else{
        setState(() {
        _loading = false;
      });
    }
  }
}
