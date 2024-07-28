import 'package:flutter/material.dart';
import 'package:new_chat_app/core/configs/theme/app_colors.dart';

class AppTheme{
  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    brightness: Brightness.light,
  );

  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColors.backgroundColor,
    brightness: Brightness.dark,
  );
}