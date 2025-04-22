import 'package:clock/clock.dart';

int getAge(DateTime dob) {
  final now = clock.now();
  final year = now.year - dob.year;
  final mth = now.month - dob.month;
  final days = now.day - dob.day;

  if (mth == 0) {
    if (days < 0) {
      return year - 1;
    } else {
      return year;
    }
  } else if (mth > 0) {
    return year;
  } else {
    return year - 1;
  }
}
