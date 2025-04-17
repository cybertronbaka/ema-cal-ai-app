part of 'custom_camera.dart';

List<double> _getZoomLevels(double min, double max) {
  // Base set of zoom levels
  final List<double> baseLevels = [0.5, 1, 2, 5, 10, 30, 100];

  // If min and max are the same, return null
  if (min == max) return [min];

  // Ensure min is less than max, swap if needed
  if (min > max) {
    final temp = min;
    min = max;
    max = temp;
  }

  // Filter base levels that fall within the min-max range
  var levels =
      baseLevels.where((level) => level >= min && level <= max).toList();

  // If the filtered list is not empty, return it
  if (levels.isNotEmpty) return levels;

  // For cases where min/max are not in base levels, generate smart levels
  levels = [];
  double current = min;

  // Determine the appropriate increment based on the max value
  double increment =
      max <= 1
          ? 0.5
          : max <= 5
          ? 1
          : max <= 10
          ? 2
          : max <= 30
          ? 5
          : max <= 100
          ? 10
          : 20;

  // Generate levels with appropriate increments
  while (current <= max) {
    levels.add(current);

    // For values less than 1, use 0.5 increments
    if (current < 1) {
      current += 0.5;
    }
    // For other values, use the determined increment
    else {
      // Round to nearest whole number for cleaner values
      current = (current + increment).roundToDouble();

      // Special cases to match the base pattern
      if (current > 2 && current < 5) current = 5;
      if (current > 5 && current < 10) current = 10;
      if (current > 10 && current < 30) current = 30;
      if (current > 30 && current < 100) current = 100;
    }

    // Ensure we don't exceed max
    if (current > max) {
      levels.add(max);
      break;
    }
  }

  return levels;
}
