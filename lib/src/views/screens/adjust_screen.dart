import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'dart:typed_data';

class AdjustScreen extends StatefulWidget {
  @override
  _AdjustScreenState createState() => _AdjustScreenState();
}

class _AdjustScreenState extends State<AdjustScreen> {
  ui.Image? image;
  bool isImageloaded = false;

  void initState() {
    super.initState();
    init();
  }

  Future<Null> init() async {
    final ByteData data = await rootBundle.load('assets/choose_a_photo.png');
    image = await loadImage(new Uint8List.view(data.buffer));
  }

  Future<ui.Image> loadImage(img) async {
    final Completer<ui.Image> completer = new Completer();
    ui.decodeImageFromList(img, (ui.Image img) {
      setState(() {
        isImageloaded = true;
      });
      return completer.complete(img);
    });
    return completer.future;
  }

  Widget _buildImage() {
    if (this.isImageloaded) {
      return new CustomPaint(
        painter: new ImageEditor(image!),
      );
    } else {
      return new Center(child: new Text('loading'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text('Hello'),
        ),
        body: new Container(
          child: _buildImage(),
        ));
  }
}

class ImageEditor extends CustomPainter {
  ImageEditor(
    this.image,
  );

  ui.Image image;

  @override
  void paint(Canvas canvas, Size size) async {
    ByteData? data = await image.toByteData();
    canvas.drawImage(image, new Offset(0.0, 0.0), new Paint());
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
