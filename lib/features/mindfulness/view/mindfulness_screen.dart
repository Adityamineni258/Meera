import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:meera/constants/app_theme.dart';
import 'package:meera/features/mindfulness/models/mindfulness_exercise.dart';
import 'package:meera/features/mindfulness/services/mindfulness_service.dart';
import 'package:meera/features/mindfulness/view/body_scan_meditation_screen.dart';
import 'package:meera/features/mindfulness/view/loving_kindness_meditation_screen.dart';
import 'package:meera/features/mindfulness/view/mindful_walking_screen.dart';
import 'package:meera/l10n/app_localizations.dart';

class MindfulnessScreen extends StatefulWidget {
  const MindfulnessScreen({super.key});

  @override
  State<MindfulnessScreen> createState() => _MindfulnessScreenState();
}

class _MindfulnessScreenState extends State<MindfulnessScreen> {
  late Future<List<MindfulnessExercise>> _exercisesFuture;

  @override
  void initState() {
    super.initState();
    _exercisesFuture = MindfulnessService().loadExercises();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.toolMindfulness, style: GoogleFonts.lexend(fontSize: 26, fontWeight: FontWeight.w500, color: AppTheme.textColor)),
      ),
      backgroundColor: AppTheme.scaffoldBackgroundColor,
      body: FutureBuilder<List<MindfulnessExercise>>(
        future: _exercisesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No exercises found.'));
          } else {
            final exercises = snapshot.data!;
            return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                final exercise = exercises[index];
                return Card(
                  color: AppTheme.cardColor,
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.0)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          exercise.title,
                          style: GoogleFonts.lexend(fontSize: 18, fontWeight: FontWeight.bold, color: AppTheme.textColor),
                        ),
                        const SizedBox(height: 4.0),
                        Text(
                          exercise.description,
                          style: GoogleFonts.lexend(color: AppTheme.textColor.withAlpha(179)),
                        ),
                        const SizedBox(height: 12.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              exercise.duration,
                              style: GoogleFonts.lexend(fontSize: 14, color: AppTheme.primaryColor, fontWeight: FontWeight.w500), 
                            ),
                            ElevatedButton(
                              onPressed: () {
                                switch (exercise.title) {
                                  case 'Body Scan Meditation':
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const BodyScanMeditationScreen()));
                                    break;
                                  case 'Mindful Walking':
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const MindfulWalkingScreen()));
                                    break;
                                  case 'Loving-Kindness Meditation':
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const LovingKindnessMeditationScreen()));
                                    break;
                                }
                              },
                              child: const Text('Start'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
