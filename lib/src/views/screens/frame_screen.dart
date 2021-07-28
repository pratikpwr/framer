import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:framer/src/views/widgets/custom_button.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart' as IMG;
import 'package:framer/src/views/widgets/custom_appBar.dart';

class FrameScreen extends StatefulWidget {
  final String imagePath;

  FrameScreen(this.imagePath);

  @override
  _FrameScreenState createState() => _FrameScreenState();
}

class _FrameScreenState extends State<FrameScreen> {
  ui.Image? image;
  ui.Image? frameImage;
  bool isLoaded = false;
  Color pickerColor = Colors.white;

  @override
  void initState() {
    init();
    super.initState();
  }

  Future<void> init() async {
    image = await _loadImage(widget.imagePath);
    frameImage = await _loadAssetImage('assets/frame1.png');
    setState(() {
      isLoaded = true;
    });
  }

  // load image as canvas can understand
  Future<ui.Image> _loadImage(String path) async {
    final File file = File(path);
    final Uint8List data = await file.readAsBytes();

    final IMG.Image? img = IMG.decodeImage(data);
    IMG.Image? resized;
    resized = IMG.copyResize(img!, height: 200);

    if (resized.width > 320) {
      resized = IMG.copyResize(img, height: 200, width: 320);
    }
    final Uint8List resizedBytes = Uint8List.fromList(IMG.encodePng(resized));
    final Completer<ui.Image> completer = new Completer();

    ui.decodeImageFromList(
        resizedBytes, (ui.Image img) => completer.complete(img));
    return completer.future;
  }

  Future<ui.Image> _loadAssetImage(String path) async {
    final ByteData byteData = await rootBundle.load(path);
    final Uint8List data = Uint8List.view(byteData.buffer);
    // final Size _size = MediaQuery.of(context).size;

    final IMG.Image? img = IMG.decodeImage(data);
    final IMG.Image? resized = IMG.copyResize(img!, height: 300, width: 400);

    final Uint8List resizedBytes = Uint8List.fromList(IMG.encodePng(resized!));
    final Completer<ui.Image> completer = new Completer();

    ui.decodeImageFromList(
        resizedBytes, (ui.Image img) => completer.complete(img));
    return completer.future;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(context: context, title: 'Add a Frame'),
      body: SafeArea(
        child: Column(
          children: [
            Center(
              child: Text(
                'Add a color and a frame.',
                style: Theme.of(context).textTheme.subtitle2,
              ),
            ),
            SizedBox(
              height: 16,
            ),
            if (isLoaded)
              FittedBox(
                child: SizedBox(
                  height: frameImage!.height.toDouble(),
                  width: frameImage!.width.toDouble(),
                  child: CustomPaint(
                    painter: FramePainter(image!, frameImage!, pickerColor),
                  ),
                ),
              )
            else
              Center(
                  child: new Text(
                'loading...',
                style: Theme.of(context).textTheme.subtitle2,
              )),
            SizedBox(
              height: 16,
            ),
            CustomButton('Change Color', () {
              _showColorDialog();
            }),
            SizedBox(
              height: 16,
            ),
            CustomButton('Change Frame', () async {
              _showFrameDialog();
            }),
          ],
        ),
      ),
    );
  }

  void _showFrameDialog() {
    showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: Text(
              'Choose a Frame',
              style: Theme.of(context).textTheme.headline6,
            ),
            scrollable: true,
            content: Container(
              height: 150,
              width: MediaQuery.of(context).size.width * 0.8,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: [
                  _frameButton('assets/frame1.png'),
                  _frameButton('assets/frame2.png'),
                  _frameButton('assets/frame3.png'),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'Cancel',
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            ],
          );
        });
  }

  Widget _frameButton(String url) {
    return InkWell(
      onTap: () async {
        final img = await _loadAssetImage(url);
        setState(() {
          frameImage = img;
        });
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.all(8),
        child: Image.asset(
          url,
          height: 60,
        ),
      ),
    );
  }

  void _showColorDialog() {
    ColorPicker(
      color: pickerColor,
      onColorChanged: (changedColor) {
        setState(() {
          pickerColor = changedColor;
        });
      },
      hasBorder: true,
      elevation: 5,
      pickersEnabled: const <ColorPickerType, bool>{
        ColorPickerType.both: false,
        ColorPickerType.primary: false,
        ColorPickerType.accent: false,
        ColorPickerType.bw: false,
        ColorPickerType.custom: false,
        ColorPickerType.wheel: true,
      },
      enableOpacity: false,
      width: 44,
      height: 44,
      borderRadius: 22,
      heading: Text(
        'Select color',
        style: Theme.of(context).textTheme.headline6,
      ),
      materialNameTextStyle: Theme.of(context).textTheme.subtitle2,
    ).showPickerDialog(
      context,
      constraints:
          const BoxConstraints(minHeight: 400, minWidth: 300, maxWidth: 320),
    );
  }
}

class FramePainter extends CustomPainter {
  // also get filter and color from user
  FramePainter(this.image, this.frameImage, this.color);

  final ui.Image image;

  final ui.Image frameImage;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final Paint _fillPaint = Paint()..color = color;
    Rect _rect = Rect.fromLTRB(0, 0, 400, 300);

    canvas.drawRect(_rect, _fillPaint);

    double xOffset = 200 - image.width / 2;
    canvas.drawImage(image, Offset(xOffset, 50), Paint());

    canvas.drawImage(frameImage, Offset(0, 0), Paint());
  }

  @override
  bool shouldRepaint(FramePainter oldDelegate) {
    // after user selects another frame and color this will redraw
    return image != oldDelegate.image ||
        frameImage != oldDelegate.frameImage ||
        color != oldDelegate.color;
    // throw UnimplementedError();
  }
}
