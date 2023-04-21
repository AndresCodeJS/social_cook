import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:social_cook/src/utils/constants.dart';
import 'package:social_cook/src/widgets/register/imageSelector.dart';
import 'package:social_cook/src/widgets/register/registerForm.dart';

import '../models/User.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  File? _image;
  final _picker = ImagePicker();

  final GlobalKey<ScaffoldState> _scaffkey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 20),
            decoration: const BoxDecoration(
                gradient: LinearGradient(colors: [
              Color.fromARGB(255, 146, 201, 209),
              Color.fromARGB(255, 11, 180, 196)
            ])),
          ),
          SizedBox(
            height: 100,
            width: double.infinity,
            child: AppBar(
                title: const Text(
                  "Registro de usuario",
                  textAlign: TextAlign.center,
                  style: TextStyle(),
                ),
                iconTheme: const IconThemeData(color: Colors.white),
                elevation: 0,
                backgroundColor: Colors.transparent),
          ),
          Container(
              margin: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.10),
              width: double.infinity,
              child: ListView(children: [
                ImageSelector(
                  openImagePicker: _openImagePicker,
                  image: _image,
                ),
                Card(
                  margin: const EdgeInsets.all(20),
                  child: Padding(
                      padding: const EdgeInsets.only(
                          top: 20, right: 40, left: 40, bottom: 40),
                      child: RegisterForm(onSave: _onSave)),
                )
              ])),
        ],
      ),
    );
  }

  Future<void> _openImagePicker(String option) async {
    final XFile? pickedImage = option == "camera"
        ? await _picker.pickImage(source: ImageSource.camera)
        : await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  void _onSave(BuildContext context, User usuario) {
    if (_image == null) {showSnackBar(context, "Seleccione una imagen",Colors.orange);}
    print("aprobado ${usuario.nombre} y la imagen $_image}");
  }

  void showSnackBar(BuildContext context, String title, Color backColor) {

     SnackBar snackBar = SnackBar(
      content: Text(title),
      backgroundColor: backColor,
      action: SnackBarAction(
          label: "Deshacer", onPressed: () => {print("Cancela deshacer")}),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
