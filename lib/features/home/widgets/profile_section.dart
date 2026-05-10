import 'package:flutter/material.dart';
import 'package:lloydportfolio/core/constants/app_colors.dart';
import 'package:lloydportfolio/core/theme/app_theme.dart';
import 'package:lloydportfolio/core/theme/font_styles.dart';
import 'package:lloydportfolio/notifiers.dart';
import 'package:lloydportfolio/features/home/widgets/intro_sheet.dart';
import 'package:lloydportfolio/features/home/widgets/search_overlay.dart';
import 'package:lloydportfolio/features/home/widgets/certificates_page.dart';
import 'package:lloydportfolio/features/home/widgets/sticky_title_bar.dart';
import 'package:lloydportfolio/data/credentials/credential_data.dart' as cred;
import 'package:lloydportfolio/data/profile/profile_data.dart' as profile;
import 'package:lloydportfolio/data/projects/project_data.dart' as proj;
import 'package:lloydportfolio/data/skills/skill_data.dart' as skill;

class ProfileSection extends StatefulWidget {
  const ProfileSection({super.key});

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
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
    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.fromLTRB(18, 0, 18, 130),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Back to splash ──────────────────────────────────
              GestureDetector(
                onTap: () => Navigator.of(context).pop(),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.arrow_back_ios_rounded,
                      size: 11,
                      color: AppColors.accent,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'BACK',
                      style: AppTextStyles.mono(
                        color: AppColors.accent,
                        size: 9,
                        weight: FontWeight.w600,
                      ).copyWith(letterSpacing: 1.4),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              // ── Name / greeting row ──────────────────────────────
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'HELLO THERE',
                          style: AppTextStyles.mono(
                            color: AppColors.accent,
                            size: 10,
                            weight: FontWeight.w600,
                          ).copyWith(letterSpacing: 1.6),
                        ),
                        const SizedBox(height: 6),
                        ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [Color(0xFFE8F8F5), AppColors.accent],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                          child: Text(
                            'Jhon Lloyd\nValencia',
                            style: AppTextStyles.headingLarge().copyWith(
                              fontSize: 30,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              height: 1.1,
                            ),
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          'Where would you like to explore?',
                          style: AppTextStyles.bodyMedium(
                            color: const Color(0x54E8F8F5),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const _ThemePickerButton(),
                ],
              ),
              const SizedBox(height: 18),
              GestureDetector(
                onTap: () => showSearchOverlay(context),
                child: Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(16, 0, 8, 0),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(100),
                    border: Border.all(color: AppColors.border2),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.search, size: 16, color: AppColors.accent),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Search for details or accomplishments',
                          style: AppTextStyles.bodyMedium(
                            color: const Color(0x54E8F8F5),
                          ),
                        ),
                      ),
                      Container(
                        width: 34,
                        height: 34,
                        decoration: BoxDecoration(
                          color: AppColors.surface3,
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: AppColors.accent.withValues(alpha: 0.18),
                          ),
                        ),
                        child: Icon(
                          Icons.search,
                          size: 16,
                          color: AppColors.accent,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _Chip(
                      label: 'All',
                      active: true,
                      onTap: () => showSearchOverlay(context),
                    ),
                    const SizedBox(width: 8),
                    _Chip(
                      label: 'Mobile',
                      onTap: () =>
                          showSearchOverlay(context, initialQuery: 'Mobile'),
                    ),
                    const SizedBox(width: 8),
                    _Chip(
                      label: 'Web',
                      onTap: () =>
                          showSearchOverlay(context, initialQuery: 'Web'),
                    ),
                    const SizedBox(width: 8),
                    _Chip(
                      label: 'Backend',
                      onTap: () =>
                          showSearchOverlay(context, initialQuery: 'Node.js'),
                    ),
                    const SizedBox(width: 8),
                    _Chip(
                      label: 'UI/UX',
                      onTap: () =>
                          showSearchOverlay(context, initialQuery: 'Figma'),
                    ),
                    const SizedBox(width: 8),
                    _Chip(
                      label: 'Frontend',
                      onTap: () =>
                          showSearchOverlay(context, initialQuery: 'HTML'),
                    ),
                    const SizedBox(width: 8),
                    _Chip(
                      label: 'DBMS',
                      onTap: () =>
                          showSearchOverlay(context, initialQuery: 'SQL'),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),
              _IntroPhotoCard(imagePath: 'assets/images/jhon_profile.jpg'),
              const SizedBox(height: 14),
              const _CollapsiblePositions(),
              const SizedBox(height: 12),
              const _CertificatesButton(),
              const SizedBox(height: 12),
              _spaceDivider(),
              const SizedBox(height: 12),
              Builder(
                builder: (context) {
                  final projectCount = proj.projects.length;
                  final skillCount = skill.skillCategories.fold(
                    0,
                    (sum, cat) => sum + cat.skills.length,
                  );
                  final certCount = cred.certificates.length;
                  final eventCount = cred.events.length;
                  final positionCount = profile.positions.length;
                  return Column(
                    children: [
                      Row(
                        children: [
                          _StatCard(label: 'Projects', value: '$projectCount'),
                          const SizedBox(width: 12),
                          _StatCard(label: 'Experience', value: '2y'),
                          const SizedBox(width: 12),
                          _StatCard(label: 'Skills', value: '$skillCount'),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          _StatCard(label: 'Certificates', value: '$certCount'),
                          const SizedBox(width: 12),
                          _StatCard(label: 'Events', value: '$eventCount'),
                          const SizedBox(width: 12),
                          _StatCard(
                            label: 'Positions',
                            value: '$positionCount',
                          ),
                        ],
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 14),
              _spaceDivider(),
              const SizedBox(height: 14),
              Row(
                children: const [
                  Expanded(
                    child: _QuickLink(
                      label: 'Projects',
                      sub: '4 works',
                      icon: Icons.folder_outlined,
                      sectionIndex: 3,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _QuickLink(
                      label: 'Skills',
                      sub: '15+ tools',
                      icon: Icons.code_outlined,
                      sectionIndex: 2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: const [
                  Expanded(
                    child: _QuickLink(
                      label: 'Academic',
                      sub: 'CS Degree',
                      icon: Icons.school_outlined,
                      sectionIndex: 1,
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: _QuickLink(
                      label: 'Contact',
                      sub: 'Get in touch',
                      icon: Icons.mail_outline,
                      sectionIndex: 4,
                    ),
                  ),
                ],
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
            title: 'Profile',
            subtitle: 'Jhon Lloyd Montalbo Valencia',
          ),
        ),
      ],
    );
  }
}

class _IntroPhotoCard extends StatelessWidget {
  const _IntroPhotoCard({required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => const IntroBottomSheet(),
      ),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(color: AppColors.border2),
          boxShadow: [
            BoxShadow(
              color: AppColors.accent.withValues(alpha: 0.06),
              blurRadius: 24,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Profile photo with accent ring + glow
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Container(
                      width: 76,
                      height: 76,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.accent.withValues(alpha: 0.35),
                            blurRadius: 22,
                            spreadRadius: 3,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 76,
                      height: 76,
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
                        imagePath,
                        width: 68,
                        height: 68,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) => Container(
                          width: 68,
                          height: 68,
                          color: AppColors.surface3,
                          child: const Icon(
                            Icons.person,
                            size: 28,
                            color: Colors.white54,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jhon Lloyd Valencia',
                        style: AppTextStyles.headingSmall().copyWith(
                          fontSize: 17,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'CS - FULL-STACK DEV',
                        style: AppTextStyles.mono(
                          color: AppColors.accent,
                          size: 9,
                          weight: FontWeight.w600,
                        ).copyWith(letterSpacing: 0.6),
                      ),
                      const SizedBox(height: 9),
                      Row(
                        children: [
                          Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: AppColors.accent,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            'Open to opportunities',
                            style: AppTextStyles.mono(
                              color: const Color(0x80E8F8F5),
                              size: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: AppColors.accentDim,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.accent.withValues(alpha: 0.25),
                    ),
                  ),
                  child: Icon(
                    Icons.north_rounded,
                    size: 15,
                    color: AppColors.accent,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              height: 1,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.accent.withValues(alpha: 0.45),
                    AppColors.accent.withValues(alpha: 0.06),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Product-focused developer passionate about clean code, elegant user interfaces, and creating impactful digital experiences that solve real-world problems. Aspiring to reach greater heights in the technology industry while embodying leadership, initiative, adaptability, and continuous growth.',
              style: AppTextStyles.bodyMedium(
                color: const Color(0x80E8F8F5),
              ).copyWith(height: 1.55),
            ),
            const SizedBox(height: 14),
            Container(
              height: 38,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.accentDeep, AppColors.accentSoft],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: AppColors.accent.withValues(alpha: 0.3),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Read Full Introduction',
                    style: AppTextStyles.mono(
                      color: AppColors.accentLight,
                      size: 11,
                      weight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 7),
                  Icon(
                    Icons.arrow_forward_rounded,
                    size: 13,
                    color: AppColors.accentLight,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Theme Picker ───────────────────────────────────────────────────────────

class _ThemePickerButton extends StatefulWidget {
  const _ThemePickerButton();

  @override
  State<_ThemePickerButton> createState() => _ThemePickerButtonState();
}

class _ThemePickerButtonState extends State<_ThemePickerButton> {
  final _layerLink = LayerLink();
  OverlayEntry? _entry;

  bool get _isOpen => _entry != null;

  void _open() {
    final overlay = Overlay.of(context);
    _entry = OverlayEntry(builder: _buildPanel);
    overlay.insert(_entry!);
    setState(() {});
  }

  void _close() {
    _entry?.remove();
    _entry = null;
    if (mounted) setState(() {});
  }

  void _toggle() => _isOpen ? _close() : _open();

  Widget _buildPanel(BuildContext ctx) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: _close,
      child: Stack(
        children: [
          CompositedTransformFollower(
            link: _layerLink,
            showWhenUnlinked: false,
            targetAnchor: Alignment.bottomRight,
            followerAnchor: Alignment.topRight,
            offset: const Offset(0, 8),
            child: GestureDetector(
              onTap: () {}, // prevent close on panel tap
              child: ValueListenableBuilder<int>(
                valueListenable: themeIndex,
                builder: (_, current, _) => _ThemePanel(
                  current: current,
                  onSelect: (i) {
                    setAppTheme(i);
                    _close();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _entry?.remove();
    _entry = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: GestureDetector(
        onTap: _toggle,
        child: ValueListenableBuilder<int>(
          valueListenable: themeIndex,
          builder: (_, current, _) {
            final palette = AppThemePalette.all[current];
            return AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: AppColors.accentDim,
                shape: BoxShape.circle,
                border: Border.all(
                  color: _isOpen
                      ? AppColors.accent
                      : AppColors.accent.withValues(alpha: 0.30),
                  width: _isOpen ? 1.5 : 1.0,
                ),
                boxShadow: _isOpen
                    ? [
                        BoxShadow(
                          color: AppColors.accent.withValues(alpha: 0.30),
                          blurRadius: 16,
                        ),
                      ]
                    : [],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.palette_outlined,
                    size: 18,
                    color: Color(0xCCFFFFFF),
                  ),
                  Positioned(
                    bottom: 8,
                    right: 8,
                    child: Container(
                      width: 9,
                      height: 9,
                      decoration: BoxDecoration(
                        color: palette.swatch,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.black.withValues(alpha: 0.4),
                          width: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _ThemePanel extends StatelessWidget {
  const _ThemePanel({required this.current, required this.onSelect});

  final int current;
  final void Function(int) onSelect;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 12, 0, 12),
        decoration: BoxDecoration(
          color: AppColors.surface2,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.border2),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.55),
              blurRadius: 28,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'THEME',
              style: AppTextStyles.mono(
                color: AppColors.accent,
                size: 9,
                weight: FontWeight.w700,
              ).copyWith(letterSpacing: 1.4),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: 240,
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: List.generate(
                  AppThemePalette.all.length,
                  (i) => _ThemeSwatch(
                    palette: AppThemePalette.all[i],
                    isSelected: i == current,
                    onTap: () => onSelect(i),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ThemeSwatch extends StatelessWidget {
  const _ThemeSwatch({
    required this.palette,
    required this.isSelected,
    required this.onTap,
  });

  final AppThemePalette palette;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: isSelected ? 38 : 32,
            height: isSelected ? 38 : 32,
            decoration: BoxDecoration(
              color: palette.swatch,
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.8)
                    : Colors.transparent,
                width: 2,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: palette.swatch.withValues(alpha: 0.5),
                        blurRadius: 12,
                        spreadRadius: 1,
                      ),
                    ]
                  : [],
            ),
          ),
          const SizedBox(height: 6),
          Text(
            palette.name,
            style: AppTextStyles.mono(
              color: isSelected
                  ? AppColors.accentLight
                  : const Color(0x54E8F8F5),
              size: 8,
              weight: isSelected ? FontWeight.w700 : FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Collapsible Positions Card ─────────────────────────────────────────────

class _CollapsiblePositions extends StatefulWidget {
  const _CollapsiblePositions();

  @override
  State<_CollapsiblePositions> createState() => _CollapsiblePositionsState();
}

class _CollapsiblePositionsState extends State<_CollapsiblePositions> {
  static const _previewCount = 3;
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final all = profile.positions;
    final shown = _expanded ? all : all.take(_previewCount).toList();
    final hasMore = all.length > _previewCount;

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
              Expanded(
                child: Text(
                  'CURRENT POSITIONS',
                  style: AppTextStyles.mono(
                    color: AppColors.accent,
                    size: 10,
                    weight: FontWeight.w600,
                  ).copyWith(letterSpacing: 1.2),
                ),
              ),
              if (hasMore)
                Text(
                  '${all.length} total',
                  style: AppTextStyles.mono(
                    color: const Color(0x54E8F8F5),
                    size: 9,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 14),
          ...shown.asMap().entries.map((entry) {
            final i = entry.key;
            final pos = entry.value;
            return Column(
              children: [
                if (i != 0) const _PositionDivider(),
                _PositionItem(
                  role: pos.role,
                  org: pos.org,
                  icon: _positionIcon(pos.iconName),
                ),
              ],
            );
          }),
          if (hasMore) ...[
            const _PositionDivider(),
            GestureDetector(
              onTap: () => setState(() => _expanded = !_expanded),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _expanded
                          ? 'Show less'
                          : 'Show ${all.length - _previewCount} more',
                      style: AppTextStyles.mono(
                        color: AppColors.accentLight,
                        size: 10,
                        weight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 5),
                    AnimatedRotation(
                      turns: _expanded ? 0.5 : 0.0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 16,
                        color: AppColors.accentLight,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _PositionItem extends StatelessWidget {
  const _PositionItem({
    required this.role,
    required this.org,
    required this.icon,
  });

  final String role;
  final String org;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.accentDim,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: AppColors.accent.withValues(alpha: 0.2),
              ),
            ),
            child: Icon(icon, size: 17, color: AppColors.accent),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  role,
                  style: AppTextStyles.bodyMedium(
                    color: const Color(0xFFE8F8F5),
                  ).copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  org,
                  style: AppTextStyles.mono(
                    color: const Color(0x73E8F8F5),
                    size: 10,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PositionDivider extends StatelessWidget {
  const _PositionDivider();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1,
      margin: const EdgeInsets.only(left: 48),
      color: AppColors.border,
    );
  }
}

class _CertificatesButton extends StatelessWidget {
  const _CertificatesButton();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.of(
        context,
      ).push(MaterialPageRoute<void>(builder: (_) => const CertificatesPage())),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border2),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.accentDeep, AppColors.accentSoft],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.workspace_premium_outlined,
                size: 17,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Certificates',
                    style: AppTextStyles.bodyLarge(
                      color: const Color(0xFFE8F8F5),
                    ).copyWith(fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'View all earned credentials',
                    style: AppTextStyles.mono(
                      color: const Color(0x54E8F8F5),
                      size: 10,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 13,
              color: Color(0x54E8F8F5),
            ),
          ],
        ),
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.label, this.active = false, this.onTap});

  final String label;
  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 32,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          gradient: active
              ? LinearGradient(colors: [AppColors.accentDeep, AppColors.accent])
              : null,
          color: active ? null : Colors.white.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(100),
          border: active ? null : Border.all(color: AppColors.border),
        ),
        alignment: Alignment.center,
        child: Text(
          label,
          style: AppTextStyles.bodyMedium(
            color: active ? Colors.white : const Color(0x99E8F8F5),
          ).copyWith(fontWeight: active ? FontWeight.w600 : FontWeight.w500),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final String value;

  const _StatCard({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              value,
              style: AppTextStyles.headingLarge(
                color: AppColors.accent,
              ).copyWith(fontSize: 26, fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: AppTextStyles.mono(
                color: const Color(0x54E8F8F5),
                size: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickLink extends StatelessWidget {
  const _QuickLink({
    required this.label,
    required this.sub,
    required this.icon,
    required this.sectionIndex,
  });

  final String label;
  final String sub;
  final IconData icon;
  final int sectionIndex;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () => navigationBarIndex.value = sectionIndex,
      child: Ink(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.border),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [AppColors.accentDeep, AppColors.accentSoft],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 16, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: AppTextStyles.bodyLarge(
                color: const Color(0xFFE8F8F5),
              ).copyWith(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 2),
            Text(
              '$sub  ->',
              style: AppTextStyles.mono(
                color: const Color(0x54E8F8F5),
                size: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget _spaceDivider() {
  return Container(
    height: 1,
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [
          Colors.transparent,
          AppColors.accent.withValues(alpha: 0.15),
          Colors.transparent,
        ],
      ),
    ),
  );
}

IconData _positionIcon(String iconName) => switch (iconName) {
  'description' => Icons.description,
  'workspace_premium' => Icons.workspace_premium,
  'people' => Icons.people,
  'flight_takeoff' => Icons.flight_takeoff,
  'school' => Icons.school,
  'addchart' => Icons.addchart,
  'ad_units' => Icons.ad_units,
  _ => Icons.circle,
};
