import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/constraints.dart';

class CustomTheme {
  static final theme = ThemeData(
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0))),
      ),
    ),
    scaffoldBackgroundColor: scaffoldBackground,
    // scaffoldBackgroundColor: const Color(0xFFEDEDED),
    appBarTheme: const AppBarTheme(elevation: 0.0, shadowColor: transparent,scrolledUnderElevation: 0.0,  color: Color(0xFFE7EBF4),),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      // selectedLabelStyle: TextStyle(color: primaryColor),
      elevation: 3,

      backgroundColor: const Color(0x00ffffff),
      selectedLabelStyle: GoogleFonts.dmSans(
          fontSize: 14.0, color: blackColor, fontWeight: FontWeight.w500),
      unselectedLabelStyle: GoogleFonts.dmSans(
          fontSize: 14.0, color: grayColor, fontWeight: FontWeight.w500),
      selectedItemColor: blackColor,
      unselectedItemColor: grayColor,
      showUnselectedLabels: true,
    ),
    inputDecorationTheme: InputDecorationTheme(
      contentPadding:
          const EdgeInsets.symmetric(vertical: 14.0, horizontal: 20.0),
      border: OutlineInputBorder(
          borderSide: const BorderSide(color: borderColor, width: 1.0),
          borderRadius: BorderRadius.circular(5.0)),
      focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: borderColor, width: 1.0),
          borderRadius: BorderRadius.circular(5.0)),
      enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: borderColor, width: 1.0),
          borderRadius: BorderRadius.circular(5.0)),
      hintStyle: GoogleFonts.poppins(
          fontWeight: FontWeight.w400, color: grayColor, fontSize: 14.0),
      //labelStyle: KTextStyle.inter(fs: 14.0, c: black, fw: FontWeight.w400),
      filled: true,
      fillColor: borderWithOpacityColor,
    ),
  );
}
