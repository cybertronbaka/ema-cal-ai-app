import 'package:ema_cal_ai/models/meal_data.dart';
import 'package:image_picker/image_picker.dart';

class AddMealDataPageData {
  const AddMealDataPageData({required this.image, required this.data});
  final XFile image;
  final MealData data;
}
