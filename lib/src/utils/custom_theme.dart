import 'package:flutter/material.dart';
import 'package:framer/src/utils/colors.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData myTheme() {
  return ThemeData(
      primaryColor: PRIMARY_COLOR,
      // scaffoldBackgroundColor: BACKGROUND_COLOR,
      canvasColor: Colors.white,
      textTheme: TextTheme(
          headline6: GoogleFonts.rubik(
            fontSize: 20,
            color: DARK_COLOR,
            fontWeight: FontWeight.w600,
          ),
          button: GoogleFonts.rubik(
            fontSize: 20,
            color: BACKGROUND_COLOR,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.1
          ),
          subtitle2: GoogleFonts.openSans(
            fontSize: 20,
            color: GREY_COLOR,
          )));
}
