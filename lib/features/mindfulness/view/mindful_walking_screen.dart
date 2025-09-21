import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meera/constants/app_theme.dart';

class MindfulWalkingScreen extends StatelessWidget {
  const MindfulWalkingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mindful Walking',
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
                'Find a quiet place where you can walk undisturbed, either indoors or outdoors.',
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  color: AppTheme.textColor,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Begin by standing still, feeling the ground beneath your feet. Notice your posture, and the sensation of your body.',
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  color: AppTheme.textColor,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'When you are ready, begin to walk slowly. Bring your attention to the sensations in your feet as they lift and fall. Notice the contact with the ground.',
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  color: AppTheme.textColor,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Pay attention to the movement of your legs, the swing of your arms, and the rhythm of your breath. If your mind wanders, gently bring it back to the sensations of walking.',
                textAlign: TextAlign.center,
                style: GoogleFonts.lexend(
                  fontSize: 18,
                  color: AppTheme.textColor,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Continue walking for a set period, or until you feel a sense of calm and presence. When you are ready, gently stop and notice how your body feels.',
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
