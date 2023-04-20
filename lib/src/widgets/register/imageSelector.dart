import 'dart:io';
import 'package:flutter/material.dart';

typedef imagePicker =Future<void> Function(String option);

class ImageSelector extends StatelessWidget {
  const ImageSelector({super.key, required this.image, required this.openImagePicker});

  final imagePicker openImagePicker;

  final File? image;

  @override
  Widget build(BuildContext context) {
    return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: (){_showDialog(context);},
                  child: ClipRRect(
                   borderRadius: BorderRadius.circular(200.0),
                    child: image != null
                        ? Image.file(
                            image!,
                            fit: BoxFit.cover,
                            height: 200,
                            width: 200,
                          )
                        : Image.asset(
                            "assets/camara.png",
                            color: Colors.white,
                            height: 200,
                            width: 200,
                          ),
                  ),
                ),
                IconButton(
                    onPressed: (){_showDialog(context);},
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ))
              ],
            );

  }

  void _showDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
         
           return SimpleDialog(
            title: const Text("Seleccione"),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            children: <Widget>[
              ListTile(
                title: const Text("Cámara"),
                leading: const Icon(Icons.add_a_photo),
                onTap: () {
                  openImagePicker("camera");
                  Navigator.of(context).pop();
                },
              ),
               ListTile(
                title: const Text("Galeria"),
                leading: const Icon(Icons.add_photo_alternate),
                onTap: () {
                  openImagePicker("gallery");
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }




}