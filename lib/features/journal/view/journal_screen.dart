import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meera/constants/app_theme.dart';

class JournalScreen extends StatelessWidget {
  const JournalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.scaffoldBackgroundColor,
      child: Center(
        child: Text(
          'Journal Screen',
          style: GoogleFonts.lexend(
            fontSize: 22,
            color: AppTheme.textColor.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}