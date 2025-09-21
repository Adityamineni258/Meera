import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meera/features/mood_tracking/mood_entry.dart';

class LocalMoodService {
  static const String _moodEntriesKey = 'mood_entries';

  Future<void> addDummyEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> dummyMoods = [
      {
        'mood': 4.0,
        'journal': 'Felt great today after a productive morning.',
        'timestamp': DateTime.now().subtract(const Duration(days: 5)).toIso8601String(),
        'stressLevel': 'Low',
      },
      {
        'mood': 2.5,
        'journal': 'A bit down due to some unexpected work issues.',
        'timestamp': DateTime.now().subtract(const Duration(days: 3)).toIso8601String(),
        'stressLevel': 'Medium',
      },
      {
        'mood': 3.5,
        'journal': 'Feeling optimistic about the upcoming week.',
        'timestamp': DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
        'stressLevel': 'Low',
      },
    ];

    final List<String> encodedEntries = dummyMoods.map((entry) => jsonEncode(entry)).toList();
    await prefs.setStringList(_moodEntriesKey, encodedEntries);
  }

  Future<List<MoodEntry>> getMoodEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? encodedEntries = prefs.getStringList(_moodEntriesKey);

    if (encodedEntries == null) {
      return [];
    }

    return encodedEntries.map((encodedEntry) {
      final Map<String, dynamic> decodedEntry = jsonDecode(encodedEntry);
      return MoodEntry.fromMap(decodedEntry);
    }).toList();
  }

  Future<void> saveMoodEntry(MoodEntry entry) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? encodedEntries = prefs.getStringList(_moodEntriesKey);

    final List<Map<String, dynamic>> entries = (encodedEntries ?? []).map((encodedEntry) {
      return jsonDecode(encodedEntry) as Map<String, dynamic>;
    }).toList();

    entries.add(entry.toMap());

    final List<String> newEncodedEntries = entries.map((e) => jsonEncode(e)).toList();
    await prefs.setStringList(_moodEntriesKey, newEncodedEntries);
  }
}
