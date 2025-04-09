part of 'enums.dart';

enum WorkoutFrequency {
  none('None', "I don't workout"),
  low('Once or Twice', 'Occasional workouts'),
  medium('3 - 5 per week', 'Regular weekly exercise'),
  high('6+ per week', 'Highly active individual');

  const WorkoutFrequency(this.label, this.description);

  final String label;
  final String description;
}
