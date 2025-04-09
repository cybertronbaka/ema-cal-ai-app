part of 'enums.dart';

enum Gender {
  male('Male'),
  female('Female'),
  other('Other');

  const Gender(this.name);
  final String name;
}
