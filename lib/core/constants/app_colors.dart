import 'package:flutter/material.dart';
import 'package:lloydportfolio/core/theme/app_theme.dart';

class AppColors {
  // Core background palette
  static Color bg = const Color(0xFF030D10);
  static Color bodyBg = const Color(0xFF030D10);

  static Color surface = const Color(0xFF071318);
  static Color surface2 = const Color(0xFF0B1C22);
  static Color surface3 = const Color(0xFF0F252D);
  static Color surface4 = const Color(0x4D0F252D);

  // Borders
  static Color border = const Color(0x0DFFFFFF);
  static Color border2 = const Color(0x17FFFFFF);

  // Accent palette
  static Color accent = const Color(0xFF00C996);
  static Color accentDeep = const Color(0xFF003D4D);
  static Color accentSoft = const Color(0xFF006B7A);
  static Color accentLight = const Color(0xFF33D9AB);

  // Accent utility tones
  static Color accentDim = const Color(0x1A00C996);
  static Color accentDim2 = const Color(0x1200C996);
  static Color accentSurface = const Color(0xFF0B2630);

  // Text/icons on accent fills — always white
  static const Color onAccent = Color(0xFFFFFFFF);

  static void updateFromPalette(AppThemePalette p) {
    bg = p.bg;
    bodyBg = p.bodyBg;
    surface = p.surface;
    surface2 = p.surface2;
    surface3 = p.surface3;
    surface4 = p.surface4;
    border = p.border;
    border2 = p.border2;
    accent = p.accent;
    accentDeep = p.accentDeep;
    accentSoft = p.accentSoft;
    accentLight = p.accentLight;
    accentDim = p.accentDim;
    accentDim2 = p.accentDim2;
    accentSurface = p.accentSurface;
  }
}
