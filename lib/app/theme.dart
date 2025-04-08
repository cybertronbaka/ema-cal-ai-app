import 'package:ema_cal_ai/app/colors.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData get data {
    const baseTextStyle = TextStyle(color: Color(0xFF1F1F1F));
    return ThemeData(
      fontFamily: 'Roboto',
      colorScheme: const ColorScheme.light(primary: AppColors.primary),
      textTheme: TextTheme(
        displayLarge: baseTextStyle.copyWith(
          fontSize: 32,
          fontWeight: FontWeight.w500,
        ),
        displayMedium: baseTextStyle.copyWith(
          fontSize: 28,
          fontWeight: FontWeight.w500,
        ),
        displaySmall: baseTextStyle.copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w500,
        ),
        titleLarge: baseTextStyle.copyWith(
          fontSize: 22,
          fontWeight: FontWeight.w500,
        ),
        titleMedium: baseTextStyle.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: baseTextStyle.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: baseTextStyle.copyWith(fontSize: 18),
        bodyMedium: baseTextStyle.copyWith(fontSize: 16),
        bodySmall: baseTextStyle.copyWith(fontSize: 12),
      ),
      buttonTheme: const ButtonThemeData(
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        shape: RoundedRectangleBorder(),
      ),
      filledButtonTheme: const FilledButtonThemeData(
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32)),
            ),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          gapPadding: 16,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(32),
          borderSide: const BorderSide(color: AppColors.inputBorder),
        ),
        contentPadding: const EdgeInsets.all(16),
        hintStyle: const TextStyle(color: AppColors.inputHint, fontSize: 16),
      ),
    );
  }
}
