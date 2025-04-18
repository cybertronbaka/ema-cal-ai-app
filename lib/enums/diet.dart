part of 'enums.dart';

enum Diet {
  standard('Standard', 'No Restrictions', FontAwesomeIcons.drumstickBite),
  pescatarian('Pescatarian', 'Fish and Vegetable Diet', FontAwesomeIcons.fish),
  vegetarian('Vegetarian', 'Plant-Based (No Meat)', FontAwesomeIcons.carrot),
  vegan('Vegan', 'Plant-Based (No Animal Product)', FontAwesomeIcons.leaf);

  const Diet(this.name, this.description, this.icon);

  final String name;
  final String description;
  final IconData icon;
}
