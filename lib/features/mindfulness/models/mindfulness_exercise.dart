class MindfulnessExercise {
  final String title;
  final String description;
  final String duration;

  MindfulnessExercise({
    required this.title,
    required this.description,
    required this.duration,
  });

  factory MindfulnessExercise.fromJson(Map<String, dynamic> json) {
    return MindfulnessExercise(
      title: json['title'],
      description: json['description'],
      duration: json['duration'],
    );
  }
}
