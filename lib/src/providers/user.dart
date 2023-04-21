import 'package:flutter/material.dart';

class User with ChangeNotifier{

  String _nombre ="" ;
  String _email = "" ;
  String _password = "" ;

  String get nombre {
    return _nombre;
  }

  String get email {
    return _email;
  }

   String get password {
    return _password;
  }


  setDatos ({String nombre = "" , required String password,required String email}){

    _nombre = nombre;
    _email = email;
    _password = password;
     notifyListeners();
  }

}

