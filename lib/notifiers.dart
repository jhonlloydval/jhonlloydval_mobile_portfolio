import 'package:flutter/material.dart';
import 'package:lloydportfolio/core/constants/app_colors.dart';
import 'package:lloydportfolio/core/theme/app_theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

ValueNotifier<int> navigationBarIndex = ValueNotifier(0);

/// 0=teal, 1=ember, 2=orchid, 3=storm, 4=citrine, 5=aurora, 6=rose, 7=ocean, 8=verdant, 9=lavender
ValueNotifier<int> themeIndex = ValueNotifier(0);

void setAppTheme(int index) {
  final palette =
      AppThemePalette.all[index.clamp(0, AppThemePalette.all.length - 1)];
  AppColors.updateFromPalette(palette);
  themeIndex.value = index;
  SharedPreferences.getInstance()
      .then((prefs) => prefs.setInt('theme_index', index))
      .catchError((_) {}); // ignore prefs errors gracefully
}

Future<void> initTheme() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getInt('theme_index') ?? 0;
    if (saved != 0) setAppTheme(saved);
  } catch (_) {
    // If shared_preferences platform channel isn't ready yet, use default theme.
  }
}
