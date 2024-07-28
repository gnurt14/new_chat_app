import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system);

  void updateTheme(ThemeMode themeMode) => state = themeMode;
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>(
      (ref) => ThemeNotifier(),
);