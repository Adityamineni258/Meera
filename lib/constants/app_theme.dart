import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const primaryColor = Color(0xFF70A1D7);
  static const darkerPrimaryColor = Color(0xFF003366); // Navy Blue
  static const scaffoldBackgroundColor = Color(0xFFE4F0E8);
  static const cardColor = Colors.white;
  static const textColor = Colors.black87;
  static const accentColor = Color(0xFFFCAE8F);

  static ThemeData get theme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      textTheme: GoogleFonts.lexendTextTheme(),
      appBarTheme: const AppBarTheme(
        backgroundColor: scaffoldBackgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
      ),
    );
  }
}