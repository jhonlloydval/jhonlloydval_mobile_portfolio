import 'package:flutter/material.dart';
import 'package:lloydportfolio/core/constants/app_colors.dart';
import 'package:lloydportfolio/core/theme/font_styles.dart';
import 'package:lloydportfolio/data/profile/profile_data.dart' as profile;

class IntroBottomSheet extends StatelessWidget {
  const IntroBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.86,
      decoration: BoxDecoration(
        color: AppColors.bg,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        border: Border.all(color: AppColors.border2),
      ),
      child: Column(
        children: [
          // Handle row with close button
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 14, 0),
            child: Row(
              children: [
                const SizedBox(width: 32),
                const Spacer(),
                Container(
                  width: 44,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.surface3,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.border2),
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      size: 16,
                      color: Color(0x99E8F8F5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Hero photo
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: 108,
                height: 108,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.42),
                      blurRadius: 36,
                      spreadRadius: 6,
                    ),
                  ],
                ),
              ),
              Container(
                width: 108,
                height: 108,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [AppColors.accent, AppColors.accentDeep],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              ),
              ClipOval(
                child: Image.asset(
                  profile.personalInfo.profileImagePath,
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                  errorBuilder: (_, _, _) => Container(
                    width: 100,
                    height: 100,
                    color: AppColors.surface3,
                    child: const Icon(
                      Icons.person,
                      size: 44,
                      color: Colors.white54,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            profile.personalInfo.fullName,
            style: AppTextStyles.headingMedium().copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            profile.personalInfo.title,
            style: AppTextStyles.mono(
              color: AppColors.accent,
              size: 11,
              weight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _InfoPill(
                icon: Icons.location_on_outlined,
                label: profile.personalInfo.location,
              ),
              const SizedBox(width: 8),
              _InfoPill(
                icon: Icons.circle,
                iconSize: 7,
                iconColor: AppColors.accent,
                label: profile.personalInfo.availabilityStatus,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 28),
            child: Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    AppColors.accent.withValues(alpha: 0.22),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 22, 24, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final bio in profile.bioSections) ...[
                    _BioSection(title: bio.title, body: bio.body),
                    const SizedBox(height: 18),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoPill extends StatelessWidget {
  const _InfoPill({
    required this.icon,
    required this.label,
    this.iconColor,
    this.iconSize,
  });

  final IconData icon;
  final String label;
  final Color? iconColor;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.accentDim,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.18)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: iconSize ?? 12,
            color: iconColor ?? const Color(0x80E8F8F5),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTextStyles.mono(color: const Color(0x99E8F8F5), size: 10),
          ),
        ],
      ),
    );
  }
}

class _BioSection extends StatelessWidget {
  const _BioSection({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.mono(
            color: AppColors.accent,
            size: 10,
            weight: FontWeight.w600,
          ).copyWith(letterSpacing: 1.4),
        ),
        const SizedBox(height: 7),
        Text(
          body,
          style: AppTextStyles.bodyMedium(
            color: const Color(0xCCE8F8F5),
          ).copyWith(height: 1.7),
        ),
      ],
    );
  }
}
