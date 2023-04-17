import 'package:flutter/material.dart';

class User with ChangeNotifier{

  String _nombre ="" ;
  String _apellido = "" ;

  User(nombre, apellido){
    _nombre = nombre;
    _apellido = apellido;
     notifyListeners();
  }

  String get nombre {
    return _nombre;
  }

  String get apellido {
    return _apellido;
  }

  set nombre (String nombre){
    _nombre = nombre;

    notifyListeners();
  }

  setDatos (String nombre, String apellido){

    _nombre = nombre;
    _apellido = apellido;
     notifyListeners();
  }

}

