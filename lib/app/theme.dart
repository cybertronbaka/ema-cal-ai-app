import 'package:ema_cal_ai/app/colors.dart';
import 'package:flutter/material.dart';

abstract class AppTheme {
  static const fontFamily = 'Poppins';
  static const baseTextStyle = TextStyle(
    color: Color(0xFF1F1F1F),
    fontFamily: 'Poppins',
  );

  static TextTheme? _textTheme;
  static TextTheme get textTheme {
    _textTheme =
        _textTheme ??
        TextTheme(
          displayLarge: baseTextStyle.copyWith(
            fontSize: 40,
            fontWeight: FontWeight.w600,
          ),
          displayMedium: baseTextStyle.copyWith(
            fontSize: 28,
            fontWeight: FontWeight.w600,
          ),
          displaySmall: baseTextStyle.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
          titleLarge: baseTextStyle.copyWith(
            fontSize: 24,
            fontWeight: FontWeight.w600,
          ),
          titleMedium: baseTextStyle.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
          titleSmall: baseTextStyle.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: baseTextStyle.copyWith(fontSize: 18),
          bodyMedium: baseTextStyle.copyWith(fontSize: 16),
          bodySmall: baseTextStyle.copyWith(fontSize: 12),
        );

    return _textTheme!;
  }

  static ThemeData get data {
    return ThemeData(
      fontFamily: fontFamily,
      fontFamilyFallback: const [fontFamily, 'Roboto'],
      colorScheme: const ColorScheme.light(primary: AppColors.primary),
      scaffoldBackgroundColor: AppColors.bgColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.bgColor,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
      ),
      textTheme: textTheme,
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
            TextStyle(
              fontSize: 18,
              fontFamily: fontFamily,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      outlinedButtonTheme: const OutlinedButtonThemeData(
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          ),
          textStyle: WidgetStatePropertyAll(
            TextStyle(
              fontSize: 18,
              fontFamily: fontFamily,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: const Color.fromARGB(100, 255, 255, 255),
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: AppColors.inputBorder),
        ),
        contentPadding: const EdgeInsets.all(12),
        hintStyle: const TextStyle(
          color: AppColors.inputHint,
          fontSize: 14,
          fontFamily: fontFamily,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)),
      ),
      dialogTheme: const DialogThemeData(insetPadding: EdgeInsets.all(20)),
      listTileTheme: ListTileThemeData(
        titleTextStyle: textTheme.bodyMedium,
        subtitleTextStyle: baseTextStyle.copyWith(fontSize: 12),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        leadingAndTrailingTextStyle: textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(500)),
        ),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: Color(0xFFF2F5FF),
      ),
      dividerTheme: const DividerThemeData(color: Color(0x639E9E9E)),
    );
  }
}
