import 'package:fooddash/config/constants/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getTheme() {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'SofiaPro',
      colorScheme: ColorScheme.fromSwatch(
        accentColor: Colors.black12,
        backgroundColor: Colors.white,
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.black12,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.black12,
        ),
      ),
      scaffoldBackgroundColor: AppColors.white,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: Colors.grey[700],
      ),
      dialogTheme: const DialogTheme(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        modalBackgroundColor: Colors.white,
        showDragHandle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
      ),
    );
  }
}
