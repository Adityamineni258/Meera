
import 'package:meera/features/mindfulness/models/mindfulness_exercise.dart';

class MindfulnessService {
  Future<List<MindfulnessExercise>> loadExercises() async {
    return [
      MindfulnessExercise(
        title: 'Dummy Exercise 1',
        description: 'This is a dummy mindfulness exercise.',
        duration: '10 min',
      ),
      MindfulnessExercise(
        title: 'Dummy Exercise 2',
        description: 'Another dummy mindfulness exercise.',
        duration: '15 min',
      ),
    ];
  }
}
