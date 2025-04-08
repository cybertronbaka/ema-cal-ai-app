import 'package:ema_cal_ai/app/colors.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static ThemeData get data {
    const fontFamily = 'Poppins';
    const baseTextStyle = TextStyle(
      color: Color(0xFF1F1F1F),
      fontFamily: 'Poppins',
    );

    return ThemeData(
      fontFamily: fontFamily,
      fontFamilyFallback: const [fontFamily, 'Roboto'],
      colorScheme: const ColorScheme.light(primary: AppColors.primary),
      textTheme: TextTheme(
        displayLarge: baseTextStyle.copyWith(
          fontSize: 32,
          fontWeight: FontWeight.w600,
          fontVariations: const [FontVariation.weight(600)],
        ),
        displayMedium: baseTextStyle.copyWith(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          fontVariations: const [FontVariation.weight(600)],
        ),
        displaySmall: baseTextStyle.copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          fontVariations: const [FontVariation.weight(600)],
        ),
        titleLarge: baseTextStyle.copyWith(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          fontVariations: const [FontVariation.weight(600)],
        ),
        titleMedium: baseTextStyle.copyWith(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          fontVariations: const [FontVariation.weight(600)],
        ),
        titleSmall: baseTextStyle.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          fontVariations: const [FontVariation.weight(600)],
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
            EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(32)),
            ),
          ),
          textStyle: WidgetStatePropertyAll(
            TextStyle(fontSize: 18, fontFamily: fontFamily),
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
        hintStyle: const TextStyle(
          color: AppColors.inputHint,
          fontSize: 16,
          fontFamily: fontFamily,
        ),
      ),
    );
  }
}
