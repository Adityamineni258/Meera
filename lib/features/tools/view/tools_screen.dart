import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meera/constants/app_theme.dart';

class ToolsScreen extends StatelessWidget {
  const ToolsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppTheme.scaffoldBackgroundColor,
      child: Center(
        child: Text(
          'Tools Screen',
          style: GoogleFonts.lexend(
            fontSize: 22,
            color: AppTheme.textColor.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}