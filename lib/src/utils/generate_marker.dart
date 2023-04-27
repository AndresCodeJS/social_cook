import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  @override

  static const textStyle = TextStyle(
    color: Colors.black,
    /* fontFamily: 'OpenSans', */
  );

   

  void paint(Canvas canvas, Size size) async {
    Paint bluePaint = Paint()..color = Colors.blue;

  /*   final Rect rect = Rect.fromLTWH(0, 0, 100, 50);
    canvas.drawRect(
      rect,
      Paint()..color = Colors.blue,
    ); */


        
    const textSpan = TextSpan(
      text: "Diego",
      style: TextStyle(fontSize: 20, color: Colors.black),
    );

     final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
      textScaleFactor: 1,
    )..layout(
        maxWidth: size.width,
      );

    /* final dx = (size.width - textPainter.width + 5) * 0.5;
    final dy = (size.height - textPainter.height) * 0.6; */
    final dx = (size.width * 0.5 - textPainter.width/2);
    final offset = Offset(dx, size.width / 4);
    textPainter.paint(canvas, offset);

    //dibujar una recta
    /* final Rect rect = Rect.fromLTWH(0, 0, 100, 50);
    canvas.drawRect(
      rect,
      Paint()..color = Colors.blue,
    ); */

    //Dibujar un circulo
    canvas.drawCircle(
        Offset(size.width *0.5, size.width *0.75 ), size.width / 6, bluePaint);
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) => false;
}

Future<Uint8List> generateImage() async {
  final recorder = ui.PictureRecorder();
  final canvas = Canvas(recorder);

  MyPainter().paint(canvas, const Size(100, 100));

  final picture = recorder.endRecording();
  final img = await picture.toImage(100, 100);
  final pngBytes = await img.toByteData(format: ui.ImageByteFormat.png);

  return pngBytes!.buffer.asUint8List();
}
