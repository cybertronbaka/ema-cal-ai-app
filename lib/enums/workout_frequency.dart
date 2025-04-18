part of 'enums.dart';

enum WorkoutFrequency {
  none('None', "I don't workout", FontAwesomeIcons.ban),
  low('Once or Twice', 'Occasional workouts', FontAwesomeIcons.personWalking),
  medium(
    '3 - 5 per week',
    'Regular weekly exercise',
    FontAwesomeIcons.personRunning,
  ),
  high('6+ per week', 'Highly active individual', FontAwesomeIcons.dumbbell);

  const WorkoutFrequency(this.label, this.description, this.icon);

  final String label;
  final String description;
  final IconData icon;
}
