import 'package:flutter/material.dart';
import 'package:framer/src/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: Text(
      'Framer!',
      style: GoogleFonts.rockSalt(
          color: PRIMARY_COLOR, fontWeight: FontWeight.bold, fontSize: 32),
    ));
  }
}
