import 'package:clock/clock.dart';

extension DateTimeExt on DateTime {
  int calculateAge() {
    final now = clock.now();

    // Calculate the difference in years
    int age = now.year - year;

    // Check if the birthday has occurred this year
    if (now.month < month || (now.month == month && now.day < day)) {
      age--; // Subtract 1 if birthday hasn't occurred yet this year
    }

    return age;
  }
}
