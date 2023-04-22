 
 import 'package:flutter/material.dart';
 
 void showSnackBar(BuildContext context, String title, Color backColor) {

     SnackBar snackBar = SnackBar(
      content: Text(title),
      backgroundColor: backColor,
     /*  action: SnackBarAction(
          label: "Deshacer", onPressed: () => {print("Cancela deshacer")}), */
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }