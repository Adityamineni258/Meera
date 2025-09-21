class MoodEntry {
  final double mood;
  final String? journal;
  final DateTime timestamp;
  final String? stressLevel;

  MoodEntry({
    required this.mood,
    this.journal,
    required this.timestamp,
    this.stressLevel,
  });

  Map<String, dynamic> toMap() {
    return {
      'mood': mood,
      'journal': journal,
      'timestamp': timestamp.toIso8601String(),
      'stressLevel': stressLevel,
    };
  }

  factory MoodEntry.fromMap(Map<String, dynamic> map) {
    return MoodEntry(
      mood: map['mood'],
      journal: map['journal'],
      timestamp: DateTime.parse(map['timestamp']),
      stressLevel: map['stressLevel'],
    );
  }
}