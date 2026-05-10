import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lloydportfolio/core/constants/app_colors.dart';
import 'package:lloydportfolio/core/theme/font_styles.dart';

/// A frosted-glass title bar that slides in from the top when the user scrolls.
///
/// Use inside a [Stack] + [AnimatedPositioned]:
/// ```dart
/// AnimatedPositioned(
///   duration: const Duration(milliseconds: 220),
///   curve: Curves.easeOutCubic,
///   top: _showStickyTitle ? 0 : -56,
///   left: 0,
///   right: 0,
///   child: StickyTitleBar(title: 'Profile', subtitle: 'Jhon Lloyd Valencia'),
/// )
/// ```
class StickyTitleBar extends StatelessWidget {
  final String title;
  final String subtitle;

  const StickyTitleBar({
    super.key,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            color: AppColors.bg.withValues(alpha: 0.72),
            border: Border(
              bottom: BorderSide(
                color: AppColors.accent.withValues(alpha: 0.14),
                width: 1,
              ),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [const Color(0xFFE8F8F5), AppColors.accent],
                ).createShader(bounds),
                child: Text(
                  title,
                  style: AppTextStyles.headingLarge().copyWith(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 0.2,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Container(
                width: 1,
                height: 14,
                color: AppColors.accent.withValues(alpha: 0.35),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  subtitle,
                  style: AppTextStyles.mono(
                    color: AppColors.accentLight,
                    size: 11,
                    weight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
