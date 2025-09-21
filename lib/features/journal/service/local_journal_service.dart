import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class JournalEntry {
  final String? audioUrl;
  final String transcript;
  final DateTime timestamp;

  JournalEntry({this.audioUrl, required this.transcript, required this.timestamp});

  Map<String, dynamic> toMap() {
    return {
      'audioUrl': audioUrl,
      'transcript': transcript,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory JournalEntry.fromMap(Map<String, dynamic> map) {
    return JournalEntry(
      audioUrl: map['audioUrl'],
      transcript: map['transcript'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}

class LocalJournalService {
  static const String _journalEntriesKey = 'journal_entries';

  Future<void> addDummyEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> dummyRewinds = [
      {
        'audioUrl': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
        'transcript': 'This is a dummy transcript for the first audio journal entry. It talks about the day and some thoughts.',
        'timestamp': DateTime.now().subtract(const Duration(days: 7)).toIso8601String(),
      },
      {
        'audioUrl': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3',
        'transcript': 'Another dummy entry. Reflecting on feelings and experiences from the past week.',
        'timestamp': DateTime.now().subtract(const Duration(days: 3)).toIso8601String(),
      },
      {
        'audioUrl': 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-3.mp3',
        'transcript': 'A short audio note about gratitude and future plans. This is a test.',
        'timestamp': DateTime.now().subtract(const Duration(days: 1)).toIso8601String(),
      },
    ];

    final List<String> encodedEntries = dummyRewinds.map((entry) => jsonEncode(entry)).toList();
    await prefs.setStringList(_journalEntriesKey, encodedEntries);
  }

  Future<List<JournalEntry>> getJournalEntries() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? encodedEntries = prefs.getStringList(_journalEntriesKey);

    if (encodedEntries == null) {
      return [];
    }

    return encodedEntries.map((encodedEntry) {
      final Map<String, dynamic> decodedEntry = jsonDecode(encodedEntry);
      return JournalEntry.fromMap(decodedEntry);
    }).toList();
  }

  Future<void> saveJournalEntry(JournalEntry entry) async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? encodedEntries = prefs.getStringList(_journalEntriesKey);

    final List<Map<String, dynamic>> entries = (encodedEntries ?? []).map((encodedEntry) {
      return jsonDecode(encodedEntry) as Map<String, dynamic>;
    }).toList();

    entries.add(entry.toMap());

    final List<String> newEncodedEntries = entries.map((e) => jsonEncode(e)).toList();
    await prefs.setStringList(_journalEntriesKey, newEncodedEntries);
  }
}
