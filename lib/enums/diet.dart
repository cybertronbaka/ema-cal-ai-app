part of 'enums.dart';

enum Diet {
  standard('Standard', 'No Restrictions'),
  pescatarian('Pescatarian', 'Fish and Vegetable Diet'),
  vegetarian('Vegetarian', 'Plant-Based (No Meat)'),
  vegan('Vegan', 'Plant-Based (No Animal Product)');

  const Diet(this.name, this.description);

  final String name;
  final String description;
}
