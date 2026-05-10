import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:lloydportfolio/core/constants/app_colors.dart';
import 'package:lloydportfolio/core/theme/font_styles.dart';
import 'package:lloydportfolio/data/projects/project_data.dart' as project_data;
import 'package:lloydportfolio/data/projects/project_model.dart';

class ProjectsSection extends StatefulWidget {
  const ProjectsSection({super.key});

  @override
  State<ProjectsSection> createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  late final PageController _pageController;
  late final ScrollController _scrollController;
  late int _currentProjectIndex;
  bool _showStickyTitle = false;

  final List<ProjectItem> projects = project_data.projects;

  @override
  void initState() {
    super.initState();
    final initialPage = projects.length * 1000;
    _currentProjectIndex = initialPage % projects.length;
    _pageController = PageController(
      viewportFraction: 0.76,
      initialPage: initialPage,
    );
    _pageController.addListener(_handlePageChange);
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
    _pageController.removeListener(_handlePageChange);
    _pageController.dispose();
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  int _wrapIndex(int index) => index % projects.length;

  void _handlePageChange() {
    if (!_pageController.hasClients) return;
    final page = _pageController.page?.round() ?? _pageController.initialPage;
    final wrapped = _wrapIndex(page);
    if (wrapped != _currentProjectIndex && mounted) {
      setState(() {
        _currentProjectIndex = wrapped;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 130),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [Color(0xFFE8F8F5), AppColors.accent],
                        ).createShader(bounds),
                        child: Text(
                          'Projects\nShowcase',
                          style: AppTextStyles.headingLarge().copyWith(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w800,
                            height: 1.05,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      '${projects.length} works',
                      style: AppTextStyles.mono(
                        color: AppColors.accent,
                        size: 10,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: SizedBox(
                  height: 360,
                  child: PageView.builder(
                    controller: _pageController,
                    padEnds: false,
                    itemBuilder: (context, index) {
                      final wrapped = _wrapIndex(index);
                      return AnimatedBuilder(
                        animation: _pageController,
                        builder: (context, child) {
                          double scale = 0.84;
                          double opacity = 0.40;

                          if (_pageController.hasClients &&
                              _pageController.position.hasContentDimensions) {
                            final page =
                                _pageController.page ??
                                _pageController.initialPage.toDouble();
                            final distance = (page - index).abs().clamp(
                              0.0,
                              1.0,
                            );
                            scale = 1.0 - (distance * 0.16);
                            opacity = 1.0 - (distance * 0.60);
                          }

                          return Center(
                            child: Opacity(
                              opacity: opacity,
                              child: Transform.scale(
                                scale: scale,
                                child: child,
                              ),
                            ),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: _ProjectCard(project: projects[wrapped]),
                        ),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 18),
              _ProjectShowcaseDetails(project: projects[_currentProjectIndex]),
              const SizedBox(height: 10),
              Center(
                child: Text(
                  'swipe to explore',
                  style: AppTextStyles.mono(
                    color: const Color(0x54E8F8F5),
                    size: 10,
                  ),
                ),
              ),
            ],
          ),
        ),
        // Sticky title bar
        AnimatedPositioned(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          top: _showStickyTitle ? 0 : -56,
          left: 0,
          right: 0,
          child: _StickyTitleBar(
            title: 'Projects Showcase',
            projectName: projects[_currentProjectIndex].title,
          ),
        ),
      ],
    );
  }
}

class _ProjectCard extends StatefulWidget {
  final ProjectItem project;

  const _ProjectCard({required this.project});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  late final PageController _imgController;
  int _imgIndex = 0;

  List<String> get _images => widget.project.imagePaths.isNotEmpty
      ? widget.project.imagePaths
      : (widget.project.imagePath != null ? [widget.project.imagePath!] : []);

  @override
  void initState() {
    super.initState();
    _imgController = PageController();
  }

  @override
  void dispose() {
    _imgController.dispose();
    super.dispose();
  }

  void _openLightbox(
    BuildContext context,
    List<String> images,
    int startIndex,
  ) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.88),
      builder: (_) => _ImageLightbox(images: images, initialIndex: startIndex),
    );
  }

  @override
  Widget build(BuildContext context) {
    final images = _images;
    return Container(
      width: 300,
      height: 330,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          colors: [AppColors.bg, AppColors.accentDeep, AppColors.surface],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(color: AppColors.accent.withValues(alpha: 0.18)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.45),
            blurRadius: 26,
            offset: const Offset(0, 14),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: widget.project.status == 'In Progress'
                  ? const Color(0x21FFBE50)
                  : AppColors.accentDim,
              borderRadius: BorderRadius.circular(100),
              border: Border.all(
                color: widget.project.status == 'In Progress'
                    ? const Color(0x42FFBE50)
                    : AppColors.accent.withValues(alpha: 0.3),
              ),
            ),
            child: Text(
              widget.project.status.toUpperCase(),
              style: AppTextStyles.mono(
                color: widget.project.status == 'In Progress'
                    ? const Color(0xFFFFD580)
                    : AppColors.accentLight,
                size: 9,
                weight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: images.isEmpty
                  ? _CardIconFallback(project: widget.project)
                  : Stack(
                      children: [
                        PageView.builder(
                          controller: _imgController,
                          itemCount: images.length,
                          onPageChanged: (i) => setState(() => _imgIndex = i),
                          itemBuilder: (_, i) => GestureDetector(
                            onTap: () => _openLightbox(context, images, i),
                            child: Image.asset(
                              images[i],
                              fit: BoxFit.cover,
                              width: double.infinity,
                              errorBuilder: (_, __, ___) =>
                                  _CardIconFallback(project: widget.project),
                            ),
                          ),
                        ),
                        // expand hint
                        Positioned(
                          top: 8,
                          right: 8,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.black.withValues(alpha: 0.45),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Icon(
                              Icons.open_in_full_rounded,
                              size: 12,
                              color: Colors.white.withValues(alpha: 0.80),
                            ),
                          ),
                        ),
                        if (images.length > 1)
                          Positioned(
                            bottom: 8,
                            left: 0,
                            right: 0,
                            child: _CompactPagerIndicator(
                              currentIndex: _imgIndex,
                              total: images.length,
                              activeColor: AppColors.accent,
                              inactiveColor: Colors.white.withValues(
                                alpha: 0.35,
                              ),
                            ),
                          ),
                      ],
                    ),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            widget.project.title,
            style: AppTextStyles.headingLarge(
              color: Colors.white,
            ).copyWith(fontSize: 26, height: 1.0),
          ),
          const SizedBox(height: 4),
          Text(
            widget.project.subtitle,
            style: AppTextStyles.bodyMedium(color: const Color(0x85FFFFFF)),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 12,
            children: widget.project.tags
                .map(
                  (tag) => Text(
                    tag,
                    style: AppTextStyles.mono(
                      color: const Color(0xE6FFFFFF),
                      size: 11,
                      weight: FontWeight.w600,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _ImageLightbox extends StatefulWidget {
  final List<String> images;
  final int initialIndex;
  const _ImageLightbox({required this.images, required this.initialIndex});

  @override
  State<_ImageLightbox> createState() => _ImageLightboxState();
}

class _ImageLightboxState extends State<_ImageLightbox> {
  late final PageController _ctrl;
  late int _index;

  @override
  void initState() {
    super.initState();
    _index = widget.initialIndex;
    _ctrl = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 40),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // image pager
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              width: double.infinity,
              child: PageView.builder(
                controller: _ctrl,
                itemCount: widget.images.length,
                onPageChanged: (i) => setState(() => _index = i),
                itemBuilder: (_, i) => InteractiveViewer(
                  minScale: 1.0,
                  maxScale: 4.0,
                  child: Image.asset(widget.images[i], fit: BoxFit.contain),
                ),
              ),
            ),
          ),
          // close button
          Positioned(
            top: 12,
            right: 12,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.55),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.close_rounded,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ),
          // dot indicators
          if (widget.images.length > 1)
            Positioned(
              bottom: 14,
              left: 16,
              right: 16,
              child: _CompactPagerIndicator(
                currentIndex: _index,
                total: widget.images.length,
                activeColor: AppColors.accent,
                inactiveColor: Colors.white.withValues(alpha: 0.40),
              ),
            ),
          // prev / next arrows
          if (widget.images.length > 1) ...[
            Positioned(
              left: 8,
              child: _NavArrow(
                icon: Icons.chevron_left_rounded,
                onTap: _index > 0
                    ? () => _ctrl.previousPage(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOutCubic,
                      )
                    : null,
              ),
            ),
            Positioned(
              right: 8,
              child: _NavArrow(
                icon: Icons.chevron_right_rounded,
                onTap: _index < widget.images.length - 1
                    ? () => _ctrl.nextPage(
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOutCubic,
                      )
                    : null,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _NavArrow extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;
  const _NavArrow({required this.icon, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        opacity: onTap != null ? 1.0 : 0.25,
        duration: const Duration(milliseconds: 150),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.45),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.white, size: 22),
        ),
      ),
    );
  }
}

class _CompactPagerIndicator extends StatelessWidget {
  final int currentIndex;
  final int total;
  final Color activeColor;
  final Color inactiveColor;

  const _CompactPagerIndicator({
    required this.currentIndex,
    required this.total,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    final visible = _visibleIndexes(currentIndex, total, 5);
    final showDots = total < 15;
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.45),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              '${currentIndex + 1}/$total',
              style: AppTextStyles.mono(
                color: Colors.white.withValues(alpha: 0.90),
                size: 9,
                weight: FontWeight.w600,
              ),
            ),
          ),
          if (showDots) ...[
            const SizedBox(width: 8),
            ...visible.map(
              (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.symmetric(horizontal: 2),
                width: currentIndex == i ? 14 : 5,
                height: 5,
                decoration: BoxDecoration(
                  color: currentIndex == i ? activeColor : inactiveColor,
                  borderRadius: BorderRadius.circular(100),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  List<int> _visibleIndexes(int current, int count, int window) {
    if (count <= window) {
      return List<int>.generate(count, (i) => i);
    }

    final half = window ~/ 2;
    var start = current - half;
    var end = start + window - 1;

    if (start < 0) {
      start = 0;
      end = window - 1;
    }
    if (end >= count) {
      end = count - 1;
      start = count - window;
    }

    return List<int>.generate(window, (i) => start + i);
  }
}

class _CardIconFallback extends StatelessWidget {
  final ProjectItem project;
  const _CardIconFallback({required this.project});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: RadialGradient(
          colors: [
            AppColors.accentDeep.withValues(alpha: 0.5),
            AppColors.surface,
          ],
          radius: 1.0,
        ),
        border: Border.all(color: Colors.white.withValues(alpha: 0.07)),
      ),
      child: Center(
        child: Icon(
          project.icon,
          size: 52,
          color: Colors.white.withValues(alpha: 0.15),
        ),
      ),
    );
  }
}

class _ProjectShowcaseDetails extends StatelessWidget {
  const _ProjectShowcaseDetails({required this.project});

  final ProjectItem project;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 220),
        child: Column(
          key: ValueKey(project.title),
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              project.title,
              style: AppTextStyles.headingMedium(
                color: const Color(0xFFE8F8F5),
              ).copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            Text(
              project.subtitle,
              style: AppTextStyles.bodyMedium(color: AppColors.accentLight),
            ),
            const SizedBox(height: 12),
            Text(
              project.details,
              style: AppTextStyles.bodyMedium(
                color: const Color(0x99E8F8F5),
              ).copyWith(height: 1.6),
            ),
            if (project.longDescription.isNotEmpty)
              ..._buildFeatures(project.longDescription),
            if (project.whyItMatters.isNotEmpty)
              ..._buildWhyItMatters(project.whyItMatters),
            if (project.sdgs.isNotEmpty) ..._buildSdgs(project.sdgs),
            const SizedBox(height: 14),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: project.tags
                  .map(
                    (tag) => Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.accentDim,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(
                          color: AppColors.accent.withValues(alpha: 0.18),
                        ),
                      ),
                      child: Text(
                        tag,
                        style: AppTextStyles.mono(
                          color: AppColors.accentLight,
                          size: 10,
                          weight: FontWeight.w600,
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildFeatures(List<FeatureItem> features) {
    return [
      const SizedBox(height: 18),
      _SectionLabel(label: 'Features'),
      const SizedBox(height: 10),
      ...features.map(
        (f) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 5),
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: AppColors.accent,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      f.title,
                      style: AppTextStyles.bodyMedium(
                        color: const Color(0xFFE8F8F5),
                      ).copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      f.description,
                      style: AppTextStyles.bodyMedium(
                        color: const Color(0x80E8F8F5),
                      ).copyWith(height: 1.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildWhyItMatters(List<String> reasons) {
    return [
      const SizedBox(height: 20),
      _SectionLabel(label: 'Why It Matters'),
      const SizedBox(height: 10),
      ...reasons.map(
        (r) => Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 6),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 9,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  r,
                  style: AppTextStyles.bodyMedium(
                    color: const Color(0x99E8F8F5),
                  ).copyWith(height: 1.55),
                ),
              ),
            ],
          ),
        ),
      ),
    ];
  }

  List<Widget> _buildSdgs(List<SdgItem> sdgs) {
    return [
      const SizedBox(height: 20),
      _SectionLabel(label: 'SDG Alignment'),
      const SizedBox(height: 10),
      ...sdgs.map(
        (s) => Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.accentDim,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: AppColors.accent.withValues(alpha: 0.3),
                  ),
                ),
                child: Text(
                  s.number,
                  style: AppTextStyles.mono(
                    color: AppColors.accent,
                    size: 9,
                    weight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      s.label,
                      style: AppTextStyles.bodyMedium(
                        color: const Color(0xFFE8F8F5),
                      ).copyWith(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      s.description,
                      style: AppTextStyles.bodyMedium(
                        color: const Color(0x80E8F8F5),
                      ).copyWith(height: 1.5),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ];
  }
}

class _SectionLabel extends StatelessWidget {
  final String label;
  const _SectionLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label.toUpperCase(),
          style: AppTextStyles.mono(
            color: AppColors.accent,
            size: 10,
            weight: FontWeight.w700,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.accent.withValues(alpha: 0.18),
          ),
        ),
      ],
    );
  }
}

class _StickyTitleBar extends StatelessWidget {
  final String title;
  final String projectName;
  const _StickyTitleBar({required this.title, required this.projectName});

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
                  projectName,
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
