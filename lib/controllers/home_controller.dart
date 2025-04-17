import 'package:ema_cal_ai/controllers/set_gpt_api_key_controller.dart';
import 'package:ema_cal_ai/models/meal_data.dart';
import 'package:ema_cal_ai/repos/gpt_meal_data/gpt_meal_data_repo.dart';
import 'package:ema_cal_ai/repos/meal_data/meal_data_repo.dart';
import 'package:ema_cal_ai/states/meal_data.dart';
import 'package:ema_cal_ai/utils/image_picker.dart';
import 'package:ema_cal_ai/utils/snackbar.dart';
import 'package:ema_cal_ai/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final homeControllerProvider = Provider.autoDispose(
  (ref) => HomeController(ref),
);

class HomeController {
  HomeController(this.ref);

  Ref ref;

  Future<void> getTodaysMealData() async {
    try {
      final data = await ref.read(mealDataRepoProvider).today();
      ref.read(mealDataTodayProvider.notifier).state = data;

      if (data.isEmpty) return;

      MealDataSum sum = const MealDataSum.zero();
      for (var e in data) {
        sum = sum + e;
      }
      ref.read(collectiveMealDataTodayProvider.notifier).state = sum;
    } catch (e, st) {
      debugPrint('$e\n$st');
    }
  }

  Future<void> getThisWeekMealData() async {
    try {
      final data = await ref.read(mealDataRepoProvider).thisWeek();
      ref.read(thisWeekMealDataProvider.notifier).state = data;
    } catch (e, st) {
      debugPrint('$e\n$st');
    }
  }

  void showImageSrcSelectionSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (ctx) {
        return CustomOptionsBottomSheet(
          items: [
            CustomOptionsBottomSheetItem.fromIcon(
              text: 'Take photo',
              icon: Icons.camera_alt,
              onSelected: () => _pickImage(context, ImageSource.camera),
            ),
            CustomOptionsBottomSheetItem.fromIcon(
              text: 'Select from Gallery',
              icon: Icons.photo_library,
              onSelected: () => _pickImage(context, ImageSource.gallery),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final image = await CustomImagePicker.pickImage(context, source);
    if (image == null) return;

    if (!context.mounted) return;
  }

  // ignore: unused_element
  Future<void> _getNutritionDataFromGpt(
    BuildContext context,
    XFile image,
  ) async {
    String? apiKey;
    try {
      apiKey = await ref.read(setGptApiKeyControllerProvider).getApiKey();
    } catch (e, st) {
      debugPrint('$e\n$st');
      if (!context.mounted) return;

      CustomSnackBar.showErrorNotification(
        context,
        'Something unexpected happened while getting your Gemini API Key',
      );

      return;
    }

    if (apiKey == null) {
      if (context.mounted) {
        CustomSnackBar.showErrorNotification(
          context,
          'Your Gemini API Key seems to be lost please go to settings and set the API Key',
        );
      }

      return;
    }

    try {
      // Todo: Need to compress image file
      // Todo: To Get input from user
      final data = await ref
          .read(gptMealDataRepoProvider)
          .estimate(
            apiKey,
            image,
            'Mushroom, cheese, oil, spring onion, chilli',
          );
      // todo: Show data in pop up and let user update values if they want
      debugPrint('got data: ${data.toJson()}');

      await ref.read(mealDataRepoProvider).add(data);

      await getTodaysMealData();
      await getThisWeekMealData();
    } catch (e, st) {
      debugPrint('$e\n$st');

      if (!context.mounted) return;

      CustomSnackBar.showErrorNotification(context, e.toString());
    }
  }
}
