library;

import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:clock/clock.dart';
import 'package:ema_cal_ai/models/meal_data.dart';
import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

part 'gemini/gemini_meal_data_repo.dart';
part 'gemini/prompt.dart';
part 'gemini/response_schema.dart';

final gptMealDataRepoProvider = Provider<GptMealDataRepo>(
  (_) => throw UnimplementedError(),
);

abstract class GptMealDataRepo {
  Future<MealData> estimate(
    String apiKey,
    Uint8List imageData,
    String? userNote,
  );
}
