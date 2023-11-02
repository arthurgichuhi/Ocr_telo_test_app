import 'package:flutter/material.dart';

abstract class AppColors {
  static const Color white = Color(0XFFFFFFFF);
  static const Color scaffoldBackground = Color(0XFFF2F4F8);
}

class AppTheme {
  AppTheme._();

  static ThemeData theme() => ThemeData(
        scaffoldBackgroundColor: AppColors.scaffoldBackground,
        appBarTheme: const AppBarTheme(
            backgroundColor: AppColors.scaffoldBackground,
            iconTheme: IconThemeData(color: Colors.black)),
      );
}
