import 'package:flutter/material.dart';
import 'package:new_chat_app/core/configs/theme/app_colors.dart';

class AppTheme{
  static final lightTheme = ThemeData(
    // primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    brightness: Brightness.light,
    // inputDecorationTheme: InputDecorationTheme(
    //   filled: true,
    //   fillColor: Colors.transparent,
    //   hintStyle: const TextStyle(
    //     color: Color(0xffA7A7A7),
    //     fontWeight: FontWeight.w500,
    //   ),
    //   contentPadding:const EdgeInsets.all(25),
    //   border: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(30),
    //     borderSide: const BorderSide(
    //       color: Colors.black,
    //       width: 0.4,
    //     ),
    //   ),
    //   enabledBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(30),
    //     borderSide: const BorderSide(
    //       color: Colors.black,
    //       width: 1,
    //     ),
    //   ),
    // ),
  );

  static final darkTheme = ThemeData(
    // primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.backgroundColor,
    brightness: Brightness.dark,
    // inputDecorationTheme: InputDecorationTheme(
    //   filled: true,
    //   fillColor: Colors.transparent,
    //   hintStyle: const TextStyle(
    //     color: Color(0xffA7A7A7),
    //     fontWeight: FontWeight.w500,
    //   ),
    //   contentPadding:const EdgeInsets.all(25),
    //   border: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(30),
    //     borderSide: const BorderSide(
    //       color: Colors.black,
    //       width: 0.4,
    //     ),
    //   ),
    //   enabledBorder: OutlineInputBorder(
    //     borderRadius: BorderRadius.circular(30),
    //     borderSide: const BorderSide(
    //       color: Colors.black,
    //       width: 1,
    //     ),
    //   ),
    // ),
  );
}