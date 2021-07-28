import 'dart:io';

import 'package:flutter/material.dart';
import 'package:framer/src/utils/colors.dart';
import 'package:framer/src/views/screens/frame_screen.dart';
import 'package:framer/src/views/widgets/custom_appBar.dart';
import 'package:framer/src/views/widgets/custom_button.dart';
import 'package:image_picker/image_picker.dart';

class ChooseScreen extends StatefulWidget {
  @override
  _ChooseScreenState createState() => _ChooseScreenState();
}

class _ChooseScreenState extends State<ChooseScreen> {
  String _imagePath = '';

  final _picker = ImagePicker();

  Widget getImageWidget(Size _size) {
    if (_imagePath != '') {
      return Image.file(
        File(_imagePath),
        height: _size.height * 0.5,
        width: _size.width,
      );
    } else {
      return Image.asset(
        'assets/choose_a_photo.png',
        height: _size.height * 0.4,
        width: _size.width * 0.8,
      );
    }
  }

  Widget getPickButton({String? title, ImageSource? source}) {
    return TextButton(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(PRIMARY_COLOR)),
        onPressed: () async {
          final _pickedFile = await _picker.pickImage(source: source!);
          if (_pickedFile != null) {
            setState(() {
              _imagePath = _pickedFile.path;
            });
          }
        },
        child: Text(
          title!,
          style: Theme.of(context).textTheme.button,
        ));
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: customAppBar(title: 'Choose a Photo', context: context),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              'Choose a Image to add a Frame',
              style: Theme.of(context).textTheme.subtitle2,
            ),
            getImageWidget(_size),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                getPickButton(title: 'Camera', source: ImageSource.camera),
                getPickButton(title: 'Gallery', source: ImageSource.gallery)
              ],
            ),
            CustomButton('Next !', () {
              if (_imagePath != '') {
                Navigator.push(context, MaterialPageRoute(builder: (_) {
                  return FrameScreen(_imagePath);
                  // return AdjustScreen();
                }));
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Please select image.')));
              }
            })
          ],
        ),
      ),
    );
  }
}
