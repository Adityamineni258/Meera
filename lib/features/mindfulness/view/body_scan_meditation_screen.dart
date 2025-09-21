import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meera/constants/app_theme.dart';

class BodyScanMeditationScreen extends StatelessWidget {
  const BodyScanMeditationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Body Scan Meditation',
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
                'Find a comfortable position, either lying down or sitting. Gently close your eyes if you feel safe doing so.',
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  color: AppTheme.textColor,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Bring your attention to your breath, noticing the gentle rise and fall of your abdomen.',
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  color: AppTheme.textColor,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Now, bring your awareness to your toes. Notice any sensations there – warmth, coolness, tingling, or nothing at all. Simply observe without judgment.',
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  color: AppTheme.textColor,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Slowly move your attention up through your feet, ankles, calves, knees, thighs, and hips. Notice each part of your body as you go.',
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  color: AppTheme.textColor,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Continue this journey up your torso, through your abdomen, chest, back, and shoulders. Then move down your arms to your fingertips.',
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  color: AppTheme.textColor,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Finally, bring your awareness to your neck, face, and the top of your head. Notice any sensations throughout your entire body.',
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
