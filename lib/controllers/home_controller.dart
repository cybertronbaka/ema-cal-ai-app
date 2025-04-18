import 'dart:async';

import 'package:ema_cal_ai/app/routes.dart';
import 'package:ema_cal_ai/models/meal_data.dart';
import 'package:ema_cal_ai/models/nav_data/add_meal_data_page_data.dart';
import 'package:ema_cal_ai/repos/gpt_meal_data/gpt_meal_data_repo.dart';
import 'package:ema_cal_ai/repos/meal_data/meal_data_repo.dart';
import 'package:ema_cal_ai/repos/streaks_repo/streaks_repo.dart';
import 'package:ema_cal_ai/states/states.dart';
import 'package:ema_cal_ai/utils/future_runner.dart';
import 'package:ema_cal_ai/utils/image_picker.dart';
import 'package:ema_cal_ai/utils/snackbar.dart';
import 'package:ema_cal_ai/widgets/dialogs/dialogs.dart';
import 'package:ema_cal_ai/widgets/sheets/sheets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';

final homeControllerProvider = Provider.autoDispose(
  (ref) => HomeController(ref),
);

class HomeController {
  HomeController(this.ref);

  Ref ref;

  Future<void> addStreak() async {
    try {
      final newCount = await ref.read(streaksRepoProvider).add();
      if (newCount == ref.read(streaksCountProvider)) return;

      ref.read(streaksCountProvider.notifier).state = newCount;
    } catch (e, st) {
      debugPrint('$e\n$st');
    }
  }

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
            CustomOptionsBottomSheetItem.fromFaIcon(
              text: 'Take photo',
              icon: FontAwesomeIcons.camera,
              onSelected: () => _pickImage(context, ImageSource.camera),
            ),
            CustomOptionsBottomSheetItem.fromFaIcon(
              text: 'Select from Gallery',
              icon: FontAwesomeIcons.images,
              onSelected: () => _pickImage(context, ImageSource.gallery),
            ),
          ],
        );
      },
    );
  }

  String? imageDescription;

  Future<bool> _askForImageDescription(
    BuildContext context,
    XFile image,
  ) async {
    imageDescription = await showImageDescriptionSheet(context, image: image);

    return imageDescription != null;
  }

  Future<void> _pickImage(BuildContext context, ImageSource source) async {
    final image = await CustomImagePicker.pickImage(
      context,
      source,
      afterPicked: _askForImageDescription,
    );
    if (image == null) return;

    if (!context.mounted) return;
    final apiKey = ref.read(userProfileProvider)?.gptApiKey;
    if (apiKey == null || apiKey.isEmpty) {
      if (context.mounted) {
        CustomSnackBar.showErrorNotification(
          context,
          'We seem to have lost your API key. Please set it in your settings',
        );
      }

      return;
    }
    await FutureRunner<MealData>(
      context: context,
      onDone: (data) async {
        if (!context.mounted) return;

        final shouldAdd = await context.pushNamed(
          Routes.addMealData.name,
          extra: AddMealDataPageData(data: data, image: image),
        );
        if (shouldAdd != null && shouldAdd is bool && shouldAdd) {
          await getTodaysMealData();
          await getThisWeekMealData();
          await addStreak();
        }
      },
    ).run(
      ref
          .read(gptMealDataRepoProvider)
          .estimate(apiKey, image, imageDescription),
    );
  }
}
