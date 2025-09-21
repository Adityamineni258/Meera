import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meera/constants/app_theme.dart';

class LovingKindnessMeditationScreen extends StatelessWidget {
  const LovingKindnessMeditationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Loving-Kindness Meditation',
          style: GoogleFonts.lexend(
            fontSize: 22,
            fontWeight: FontWeight.w500,
            color: AppTheme.textColor,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Find a comfortable position, either sitting or lying down. Gently close your eyes if you feel safe.',
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  color: AppTheme.textColor,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Bring to mind someone you deeply care about. Feel the warmth and love you have for them. Silently repeat: May you be happy. May you be healthy. May you be safe. May you live with ease.',
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  color: AppTheme.textColor,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Next, bring to mind someone you feel neutral about, perhaps an acquaintance. Extend the same wishes to them: May you be happy. May you be healthy. May you be safe. May you live with ease.',
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  color: AppTheme.textColor,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Now, bring to mind someone you find challenging. This can be difficult, but try to extend the same wishes: May you be happy. May you be healthy. May you be safe. May you live with ease.',
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  color: AppTheme.textColor,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Finally, extend these wishes to all beings everywhere: May all beings be happy. May all beings be healthy. May all beings be safe. May all beings live with ease.',
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  color: AppTheme.textColor,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'When you are ready, gently open your eyes, bringing your awareness back to the room.',
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  color: AppTheme.textColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
