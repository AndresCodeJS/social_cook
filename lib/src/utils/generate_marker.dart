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


/* Future<Uint8List> getCustomMarkerIcon(String text) async {
  final  pictureRecorder = ui.PictureRecorder();
  final Canvas canvas = Canvas(pictureRecorder);

  final double width = 80.0;
  final double height = 80.0;

  final TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
  textPainter.text = TextSpan(
    text: text,
    style: TextStyle(fontSize: 20, color: Colors.white),
  );



  final Rect rect = Rect.fromLTWH(0, 0, width, height);

  canvas.drawRect(
    rect,
    Paint()..color = Colors.blue,
  );

  canvas.drawCircle(
      Offset(width / 2, height / 2), 20, Paint()..color = Colors.white);

  textPainter.paint(
    canvas,
    Offset(
      rect.center.dx - textPainter.width / 2,
      rect.center.dy - textPainter.height / 2,
    ),
  );

  final img = await pictureRecorder.endRecording().toImage(width.toInt(), height.toInt());
  final data = await img.toByteData(format: ui.ImageByteFormat.png);

  return data!.buffer.asUint8List();
} */