import 'package:flutter/material.dart';
import 'package:lloydportfolio/core/constants/app_colors.dart';
import 'package:lloydportfolio/core/theme/font_styles.dart';
import 'package:lloydportfolio/features/home/widgets/sticky_title_bar.dart';
import 'package:lloydportfolio/data/skills/skill_data.dart' as skill_data;
import 'package:lloydportfolio/data/skills/skill_model.dart';

class SkillsSection extends StatefulWidget {
  const SkillsSection({super.key});

  @override
  State<SkillsSection> createState() => _SkillsSectionState();
}

class _SkillsSectionState extends State<SkillsSection> {
  late final ScrollController _scrollController;
  bool _showStickyTitle = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_handleScroll);
  }

  void _handleScroll() {
    final shouldShow = _scrollController.offset > 72;
    if (shouldShow != _showStickyTitle) {
      setState(() => _showStickyTitle = shouldShow);
    }
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final skillCategories = skill_data.skillCategories;

    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 130),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Color(0xFFE8F8F5), AppColors.accent],
                ).createShader(bounds),
                child: Text(
                  'Skills &\nCompetencies',
                  style: AppTextStyles.headingLarge().copyWith(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    height: 1.05,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Technologies & tools',
                style: AppTextStyles.bodyMedium(color: const Color(0x54E8F8F5)),
              ),
              const SizedBox(height: 22),
              ...skillCategories.map(
                (category) => _SkillCategoryWidget(category: category),
              ),
            ],
          ),
        ),
        AnimatedPositioned(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          top: _showStickyTitle ? 0 : -56,
          left: 0,
          right: 0,
          child: const StickyTitleBar(
            title: 'Skills & Competencies',
            subtitle: 'Technologies',
          ),
        ),
      ],
    );
  }
}

class _SkillCategoryWidget extends StatelessWidget {
  final SkillCategory category;

  const _SkillCategoryWidget({required this.category});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          category.title.toUpperCase(),
          style: AppTextStyles.mono(
            color: AppColors.accent,
            size: 10,
            weight: FontWeight.w600,
          ).copyWith(letterSpacing: 1.5),
        ),
        const SizedBox(height: 11),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: category.skills
              .map((skill) => _SkillBadge(skill: skill))
              .toList(),
        ),
        const SizedBox(height: 22),
      ],
    );
  }
}

class _SkillBadge extends StatelessWidget {
  final String skill;

  const _SkillBadge({required this.skill});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: AppColors.accentDim,
        borderRadius: BorderRadius.circular(100),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.18)),
      ),
      child: Text(
        skill,
        style: AppTextStyles.bodyMedium(
          color: const Color(0xCCE8F8F5),
        ).copyWith(fontWeight: FontWeight.w500),
      ),
    );
  }
}
