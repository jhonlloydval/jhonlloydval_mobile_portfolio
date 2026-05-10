import 'package:flutter/material.dart';
import 'package:lloydportfolio/core/constants/app_colors.dart';
import 'package:lloydportfolio/core/theme/font_styles.dart';
import 'package:lloydportfolio/data/academic/academic_data.dart' as acad;

class AcademicSection extends StatefulWidget {
  const AcademicSection({super.key});

  @override
  State<AcademicSection> createState() => _AcademicSectionState();
}

class _AcademicSectionState extends State<AcademicSection> {
  late final PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _goToIndex(int index) {
    setState(() => _currentIndex = index);
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 260),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ── Static header ─────────────────────────────────────────────────
        Padding(
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Color(0xFFE8F8F5), AppColors.accent],
                ).createShader(bounds),
                child: Text(
                  'Academic\nBackground',
                  style: AppTextStyles.headingLarge().copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w800,
                    fontSize: 30,
                    height: 1.05,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _currentIndex == 0
                    ? 'Education, certifications, and leadership'
                    : 'Competitions, hackathons & achievements',
                style: AppTextStyles.bodyMedium(color: const Color(0x54E8F8F5)),
              ),
              const SizedBox(height: 14),
              _AcademicSwitch(
                currentIndex: _currentIndex,
                onChanged: _goToIndex,
              ),
              const SizedBox(height: 18),
            ],
          ),
        ),
        // ── Scrollable content ────────────────────────────────────────────
        Expanded(
          child: PageView(
            controller: _pageController,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            children: const [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: _AcademicSlide(),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18),
                child: _CompetitionSlide(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _AcademicSwitch extends StatelessWidget {
  const _AcademicSwitch({required this.currentIndex, required this.onChanged});

  final int currentIndex;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppColors.border),
      ),
      child: Row(
        children: [
          Expanded(
            child: _SwitchButton(
              label: 'Academic Background',
              active: currentIndex == 0,
              onTap: () => onChanged(0),
            ),
          ),
          Expanded(
            child: _SwitchButton(
              label: 'Achievements',
              active: currentIndex == 1,
              onTap: () => onChanged(1),
            ),
          ),
        ],
      ),
    );
  }
}

class _SwitchButton extends StatelessWidget {
  const _SwitchButton({
    required this.label,
    required this.active,
    required this.onTap,
  });

  final String label;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: active ? AppColors.accentDim : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          border: active
              ? Border.all(color: AppColors.accent.withValues(alpha: 0.2))
              : null,
        ),
        child: Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.mono(
            color: active ? AppColors.accentLight : const Color(0x80E8F8F5),
            size: 10,
            weight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}

class _AcademicSlide extends StatelessWidget {
  const _AcademicSlide();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (final e in acad.educationList) ...[
            _EducationCard(
              degree: e.degree,
              field: e.field,
              institution: e.institution,
              duration: e.duration,
              details: e.details,
            ),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}

class _CompetitionSlide extends StatelessWidget {
  const _CompetitionSlide();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          for (final a in acad.achievementsList) ...[
            _ExperienceCard(
              title: a.title,
              category: a.category,
              event: a.event,
              period: a.period,
              summary: a.summary,
            ),
            const SizedBox(height: 16),
          ],
        ],
      ),
    );
  }
}

class _EducationCard extends StatelessWidget {
  final String degree;
  final String field;
  final String institution;
  final String duration;
  final String details;

  const _EducationCard({
    required this.degree,
    required this.field,
    required this.institution,
    required this.duration,
    required this.details,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(degree, style: AppTextStyles.headingSmall()),
                    const SizedBox(height: 4),
                    Text(
                      field,
                      style: AppTextStyles.bodyLarge(color: AppColors.accent),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accentDim,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: AppColors.accent.withValues(alpha: 0.2),
                  ),
                ),
                child: Text(
                  duration,
                  style: AppTextStyles.mono(
                    color: AppColors.accentLight,
                    size: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            institution,
            style: AppTextStyles.bodyMedium(color: const Color(0xCCE8F8F5)),
          ),
          const SizedBox(height: 12),
          Text(
            details,
            style: AppTextStyles.bodyMedium(color: const Color(0x99E8F8F5)),
          ),
        ],
      ),
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  const _ExperienceCard({
    required this.title,
    required this.category,
    required this.event,
    required this.period,
    required this.summary,
  });

  final String title;
  final String category;
  final String event;
  final String period;
  final String summary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(title, style: AppTextStyles.headingSmall())),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: AppColors.accentDim,
                  borderRadius: BorderRadius.circular(100),
                  border: Border.all(
                    color: AppColors.accent.withValues(alpha: 0.2),
                  ),
                ),
                child: Text(
                  period,
                  style: AppTextStyles.mono(
                    color: AppColors.accentLight,
                    size: 10,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            category,
            style: AppTextStyles.bodyLarge(color: AppColors.accent),
          ),
          const SizedBox(height: 4),
          Text(
            event,
            style: AppTextStyles.bodyMedium(color: const Color(0xCCE8F8F5)),
          ),
          const SizedBox(height: 10),
          Text(
            summary,
            style: AppTextStyles.bodyMedium(color: const Color(0x99E8F8F5)),
          ),
        ],
      ),
    );
  }
}
