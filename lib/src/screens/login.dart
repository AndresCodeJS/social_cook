import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_cook/src/providers/user.dart';
import 'package:social_cook/src/widgets/login/logo.dart';


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

    final user = Provider.of<User>(context);
    
    return Scaffold(
        body: Form(
          key: _formKey,
          child: Stack(
              children: <Widget>[
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 146, 201, 209),
              Color.fromARGB(255, 11, 180, 196)
            ])),
            child: const Logo(),
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
                            _login(context, user);
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
                              TextButton(onPressed: () => {_onRegister(context)}, child: const Text("Registrate"))
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

  void _login(BuildContext context, User user) {
    if (!_loading) {
      setState(() {
        _loading = true;
      });
    }
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      print("Hola $userName , $password");
      user.setDatos(userName, password);
      Navigator.of(context).pushNamed("/homePage");
      _loading = false;
    }else{
        setState(() {
        _loading = false;
      });
    }
  }
  
  _onRegister(BuildContext context) {

    Navigator.of(context).pushNamed("/register");
  }
}