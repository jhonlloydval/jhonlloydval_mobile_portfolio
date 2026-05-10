import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Centralised typography styles for Lloyd's portfolio.
///
/// Display / title text → Poppins (bold, high impact)
/// Body / UI text       → DM Sans (clean, readable)
class AppTextStyles {
  AppTextStyles._();

  // ─────────────────────────────────────────────────────────────
  //  Poppins — headlines & display
  // ─────────────────────────────────────────────────────────────

  /// Hero name — e.g. "Jhon Lloyd Montalbo Valencia"
  static TextStyle displayName({Color? color}) => GoogleFonts.poppins(
    fontSize: 42,
    fontWeight: FontWeight.w700,
    height: 1.15,
    letterSpacing: -0.5,
    color: color ?? Colors.white,
  );

  /// Large section heading
  static TextStyle headingLarge({Color? color}) => GoogleFonts.poppins(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    height: 1.25,
    letterSpacing: -0.3,
    color: color ?? Colors.white,
  );

  /// Medium section heading
  static TextStyle headingMedium({Color? color}) => GoogleFonts.poppins(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    height: 1.3,
    color: color ?? Colors.white,
  );

  /// Small heading / card title
  static TextStyle headingSmall({Color? color}) => GoogleFonts.poppins(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    height: 1.4,
    color: color ?? Colors.white,
  );

  // ─────────────────────────────────────────────────────────────
  //  DM Sans — body, labels, buttons, captions
  // ─────────────────────────────────────────────────────────────

  /// Subtitle directly under the hero name
  static TextStyle subtitle({Color? color}) => GoogleFonts.dmSans(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    height: 1.6,
    letterSpacing: 0.4,
    color: color ?? const Color(0x99E8F8F5),
  );

  /// Body text — paragraphs, descriptions
  static TextStyle bodyLarge({Color? color}) => GoogleFonts.dmSans(
    fontSize: 15,
    fontWeight: FontWeight.w400,
    height: 1.65,
    color: color ?? const Color(0x99E8F8F5),
  );

  static TextStyle bodyMedium({Color? color}) => GoogleFonts.dmSans(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    height: 1.6,
    color: color ?? const Color(0x80E8F8F5),
  );

  /// Button label — primary
  static TextStyle buttonPrimary({Color? color}) => GoogleFonts.dmSans(
    fontSize: 15,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.3,
    color: color ?? Colors.white,
  );

  /// Button label — outlined / ghost
  static TextStyle buttonOutlined({Color? color}) => GoogleFonts.dmSans(
    fontSize: 15,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.3,
    color: color ?? Colors.white,
  );

  /// Overline / eyebrow label above titles
  static TextStyle eyebrow({Color? color}) => GoogleFonts.dmSans(
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 2.5,
    color: color,
  );

  /// Caption / helper text
  static TextStyle caption({Color? color}) => GoogleFonts.dmSans(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    height: 1.5,
    color: color ?? const Color(0x54E8F8F5),
  );

  /// Mono labels used for chips/badges/timestamps.
  static TextStyle mono({Color? color, double size = 11, FontWeight? weight}) =>
      GoogleFonts.dmMono(
        fontSize: size,
        fontWeight: weight ?? FontWeight.w500,
        letterSpacing: 0.6,
        color: color ?? const Color(0x99E8F8F5),
      );
}
