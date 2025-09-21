import 'package:flutter/material.dart';

import 'package:meera/features/coping/view/coping_screen.dart'; // Import for Coping
import 'package:meera/features/helplines/view/helplines_screen.dart'; // Import for Helplines
import 'package:meera/features/shell/home_screen.dart'; // Import HomeScreen

import 'history_page.dart';
import 'mood_entry.dart';
import 'local_mood_service.dart'; // Use the local service

class MoodScreen extends StatefulWidget { // Renamed from MyHomePage
  const MoodScreen({super.key});

  @override
  MoodScreenState createState() => MoodScreenState(); // Renamed from MyHomePageState
}

class MoodScreenState extends State<MoodScreen> {
  double _currentMood = 3.0;
  final TextEditingController _journalController = TextEditingController();
  final LocalMoodService _moodService = LocalMoodService();

  void _saveMood() async {
    if (_currentMood <= 3) {
      _showStressInquiry();
    } else {
      _showPositiveFeedback();
      await _finalizeSave(null);
    }
  }

  void _showStressInquiry() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Are you feeling stressed?', style: TextStyle(fontWeight: FontWeight.bold)),
          actions: <Widget>[
            TextButton(
              child: const Text('No', style: TextStyle(color: Colors.purple)),
              onPressed: () {
                Navigator.of(context).pop();
                _showActionableGuidance(false);
                _finalizeSave(null);
              },
            ),
            TextButton(
              child: const Text('Yes', style: TextStyle(color: Colors.purple)),
              onPressed: () {
                Navigator.of(context).pop();
                _showStressLevelPicker();
              },
            ),
          ],
        );
      },
    );
  }

  void _showStressLevelPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: const Text('Select Stress Level', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('Low'),
                onTap: () {
                  Navigator.of(context).pop();
                  _showActionableGuidance(true);
                  _finalizeSave('Low');
                },
              ),
              ListTile(
                title: const Text('Medium'),
                onTap: () {
                  Navigator.of(context).pop();
                  _showActionableGuidance(true);
                  _finalizeSave('Medium');
                },
              ),
              ListTile(
                title: const Text('High'),
                onTap: () {
                  Navigator.of(context).pop();
                  _showActionableGuidance(true);
                  _finalizeSave('High');
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _finalizeSave(String? stressLevel) async {
    await _moodService.saveMoodEntry(
      MoodEntry(
        mood: _currentMood,
        journal: _journalController.text,
        timestamp: DateTime.now(),
        stressLevel: stressLevel,
      ),
    );
    setState(() {
      _journalController.clear();
      _currentMood = 3.0;
    });
    // Navigate to HomeScreen after saving mood
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    }
  }

  void _showActionableGuidance(bool isStressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              const Text('Hey there '),
              const Text('👋'),
            ],
          ),
          content: Text(isStressed
              ? 'It seems like you are having a tough time. Remember, it is okay to not be okay. Here are some things that might help:'
              : 'Sometimes we all feel a little down. A small act of self-care can make a big difference.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Try a Breathing Exercise', style: TextStyle(color: Colors.purple)),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CopingScreen())); // Navigate to Coping
              },
            ),
            TextButton(
              child: const Text('Talk it Out', style: TextStyle(color: Colors.purple)),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HelplinesScreen())); // Navigate to Helplines
              },
            ),
          ],
        );
      },
    );
  }

  void _showPositiveFeedback() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          title: Row(
            children: [
              const Text("That's great to hear! "),
              const Text('😄'),
            ],
          ),
          content: const Text("Keep up the positive vibes! What's making you feel so good today?"),
          actions: <Widget>[
            TextButton(
              child: const Text('Close', style: TextStyle(color: Colors.purple)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String _getMoodEmoji(double mood) {
    if (mood <= 1) return '😔';
    if (mood <= 2) return '😟';
    if (mood <= 3) return '😐';
    if (mood <= 4) return '🙂';
    return '😄';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.access_time, color: Colors.black54),
          onPressed: () {
            Navigator.push( // Uncommented
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      HistoryPage(localMoodService: _moodService)),
            );
          },
        ),
        title: const Text(
          'Mood Tracker',
          style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontFamily: 'Poppins'),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'How are you feeling?',
                style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87),
              ),
              const SizedBox(height: 30),
              Text(
                _getMoodEmoji(_currentMood),
                style: const TextStyle(fontSize: 80),
              ),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pink.withAlpha(25),
                      spreadRadius: 3,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 10.0,
                        trackShape: const GradientRectSliderTrackShape(),
                        thumbShape: const RoundSliderThumbShape(
                            enabledThumbRadius: 12.0),
                        overlayShape:
                            const RoundSliderOverlayShape(overlayRadius: 24.0),
                      ),
                      child: Slider(
                        value: _currentMood,
                        min: 1,
                        max: 5,
                        divisions: 4,
                        onChanged: (double value) {
                          setState(() {
                            _currentMood = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.pink.withAlpha(25),
                      spreadRadius: 3,
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: TextField(
                  controller: _journalController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    hintText: "What's on your mind?",
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: _saveMood,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.purple,
                  elevation: 5,
                  shadowColor: Colors.pink.withAlpha(51),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 60, vertical: 15),
                ),
                child: const Text(
                  'Save Mood',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class GradientRectSliderTrackShape extends SliderTrackShape
    with BaseSliderTrackShape {
  const GradientRectSliderTrackShape();

  @override
  void paint(
    PaintingContext context,
    Offset offset,
    {
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required Animation<double> enableAnimation,
    required TextDirection textDirection,
    required Offset thumbCenter,
    Offset? secondaryOffset,
    bool isDiscrete = false,
    bool isEnabled = false,
    double additionalActiveTrackHeight = 2,
  }) {
    final Rect trackRect = getPreferredRect(
      parentBox: parentBox,
      offset: offset,
      sliderTheme: sliderTheme,
      isEnabled: isEnabled,
      isDiscrete: isDiscrete,
    );

    final Gradient gradient = const LinearGradient(
      colors: [Colors.purpleAccent, Colors.pinkAccent],
    );

    final Paint paint = Paint()..shader = gradient.createShader(trackRect);

    context.canvas.drawRRect(
      RRect.fromRectAndRadius(trackRect, const Radius.circular(10)),
      paint,
    );
  }
}