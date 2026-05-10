import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:lloydportfolio/core/constants/app_colors.dart';
import 'package:lloydportfolio/notifiers.dart';
import 'package:lloydportfolio/features/home/widgets/profile_section.dart';
import 'package:lloydportfolio/features/home/widgets/academic_section.dart';
import 'package:lloydportfolio/features/home/widgets/skills_section.dart';
import 'package:lloydportfolio/features/home/widgets/projects_section.dart';
import 'package:lloydportfolio/features/home/widgets/contact_section.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<NavItem> navItems = [
    NavItem(
      label: 'Profile',
      icon: Icons.person_outline,
      selectedIcon: Icons.person,
    ),
    NavItem(
      label: 'Academic',
      icon: Icons.school_outlined,
      selectedIcon: Icons.school,
    ),
    NavItem(
      label: 'Skills',
      icon: Icons.code_outlined,
      selectedIcon: Icons.code,
    ),
    NavItem(
      label: 'Projects',
      icon: Icons.folder_outlined,
      selectedIcon: Icons.folder,
    ),
    NavItem(
      label: 'Contact',
      icon: Icons.mail_outline,
      selectedIcon: Icons.mail,
    ),
  ];

  List<Widget> get sections => [
    ProfileSection(),
    AcademicSection(),
    SkillsSection(),
    ProjectsSection(),
    ContactSection(),
  ];

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
      valueListenable: themeIndex,
      builder: (context, theme, _) {
        return ValueListenableBuilder<int>(
          valueListenable: navigationBarIndex,
          builder: (context, index, _) {
            final currentSections = sections;
            return PopScope(
              canPop: true,
              child: Scaffold(
                backgroundColor: AppColors.bg,
                body: Stack(
                  children: [
                    Positioned.fill(
                      child: _AtmosphereBackground(themeKey: theme),
                    ),
                    SafeArea(
                      bottom: false,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: IndexedStack(
                          key: ValueKey(theme),
                          index: index,
                          children: currentSections,
                        ),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: _FloatingNavBar(
                        items: navItems,
                        selectedIndex: index,
                        onItemSelected: (newIndex) {
                          setState(() {
                            navigationBarIndex.value = newIndex;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class NavItem {
  final String label;
  final IconData icon;
  final IconData selectedIcon;

  NavItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });
}

class _FloatingNavBar extends StatelessWidget {
  final List<NavItem> items;
  final int selectedIndex;
  final Function(int) onItemSelected;

  const _FloatingNavBar({
    required this.items,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 18),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                color: AppColors.surface.withValues(alpha: 0.90),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: AppColors.accent.withValues(alpha: 0.12),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.55),
                    blurRadius: 26,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final selectedWidth = constraints.maxWidth * 0.30;
                  final unselectedWidth =
                      (constraints.maxWidth - selectedWidth) /
                      (items.length - 1);

                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: List.generate(
                      items.length,
                      (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 260),
                        curve: Curves.easeOutCubic,
                        width: index == selectedIndex
                            ? selectedWidth
                            : unselectedWidth,
                        child: _NavItem(
                          item: items[index],
                          isSelected: index == selectedIndex,
                          onTap: () => onItemSelected(index),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final NavItem item;
  final bool isSelected;
  final VoidCallback onTap;

  const _NavItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 260),
        curve: Curves.easeOut,
        height: double.infinity,
        margin: EdgeInsets.symmetric(
          horizontal: 2,
          vertical: isSelected ? 0 : 4,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.accentDim.withValues(alpha: 0.95)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(999),
          border: isSelected
              ? Border.all(color: AppColors.accent.withValues(alpha: 0.24))
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              isSelected ? item.selectedIcon : item.icon,
              color: isSelected ? Colors.white : const Color(0xFFE8F8F5),
              size: 23,
            ),
          ],
        ),
      ),
    );
  }
}

class _AtmosphereBackground extends StatelessWidget {
  const _AtmosphereBackground({this.themeKey});

  final int? themeKey;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -180,
          right: -170,
          child: _AtmosphereBlob(
            size: 540,
            color: AppColors.accentDeep.withValues(alpha: 0.60),
          ),
        ),
        Positioned(
          bottom: 90,
          left: -130,
          child: _AtmosphereBlob(
            size: 360,
            color: AppColors.accent.withValues(alpha: 0.14),
          ),
        ),
        Positioned(
          top: 280,
          left: 110,
          child: _AtmosphereBlob(
            size: 250,
            color: AppColors.accentSoft.withValues(alpha: 0.24),
          ),
        ),
      ],
    );
  }
}

class _AtmosphereBlob extends StatelessWidget {
  const _AtmosphereBlob({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [color, Colors.transparent],
          stops: const [0.0, 0.72],
        ),
      ),
    );
  }
}
