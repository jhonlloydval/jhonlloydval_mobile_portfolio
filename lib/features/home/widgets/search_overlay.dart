import 'package:flutter/material.dart';
import 'package:lloydportfolio/core/constants/app_colors.dart';
import 'package:lloydportfolio/core/theme/font_styles.dart';
import 'package:lloydportfolio/data/academic/academic_data.dart' as acad;
import 'package:lloydportfolio/data/credentials/credential_data.dart' as cred;
import 'package:lloydportfolio/data/profile/profile_data.dart' as prof;
import 'package:lloydportfolio/data/projects/project_data.dart' as proj;
import 'package:lloydportfolio/data/skills/skill_data.dart' as skill;
import 'package:lloydportfolio/notifiers.dart';

// ── Public entry point ────────────────────────────────────────────────────────

void showSearchOverlay(BuildContext context, {String initialQuery = ''}) {
  showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _SearchOverlay(initialQuery: initialQuery),
  );
}

// ── Internal result model ─────────────────────────────────────────────────────

enum _Category {
  project,
  skill,
  academic,
  achievement,
  certificate,
  event,
  position,
}

class _SearchResult {
  const _SearchResult({
    required this.category,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.sectionIndex,
    this.searchExtra = '',
  });

  final _Category category;
  final String title;
  final String subtitle;
  final IconData icon;
  final int sectionIndex;
  final String searchExtra;
}

// ── Build full search index once ──────────────────────────────────────────────

List<_SearchResult> _buildIndex() {
  final out = <_SearchResult>[];

  for (final p in proj.projects) {
    out.add(
      _SearchResult(
        category: _Category.project,
        title: p.title,
        subtitle: p.subtitle,
        icon: p.icon,
        sectionIndex: 3,
        searchExtra: '${p.tags.join(' ')} ${p.details}',
      ),
    );
  }

  for (final cat in skill.skillCategories) {
    for (final s in cat.skills) {
      out.add(
        _SearchResult(
          category: _Category.skill,
          title: s,
          subtitle: cat.title,
          icon: Icons.code_outlined,
          sectionIndex: 2,
          searchExtra: cat.title,
        ),
      );
    }
  }

  for (final e in acad.educationList) {
    out.add(
      _SearchResult(
        category: _Category.academic,
        title: e.degree,
        subtitle: e.institution,
        icon: Icons.school_outlined,
        sectionIndex: 1,
        searchExtra: '${e.field} ${e.details}',
      ),
    );
  }

  for (final a in acad.achievementsList) {
    out.add(
      _SearchResult(
        category: _Category.achievement,
        title: a.title,
        subtitle: a.event,
        icon: Icons.emoji_events_outlined,
        sectionIndex: 1,
        searchExtra: '${a.category} ${a.summary}',
      ),
    );
  }

  for (final c in cred.certificates) {
    out.add(
      _SearchResult(
        category: _Category.certificate,
        title: c.name,
        subtitle: c.issuer,
        icon: Icons.workspace_premium_outlined,
        sectionIndex: 0,
        searchExtra: '${c.category} ${c.year}',
      ),
    );
  }

  for (final e in cred.events) {
    out.add(
      _SearchResult(
        category: _Category.event,
        title: e.name,
        subtitle: e.organizer,
        icon: Icons.event_outlined,
        sectionIndex: 0,
        searchExtra: '${e.type} ${e.year}',
      ),
    );
  }

  for (final p in prof.positions) {
    out.add(
      _SearchResult(
        category: _Category.position,
        title: p.role,
        subtitle: p.org,
        icon: Icons.badge_outlined,
        sectionIndex: 0,
        searchExtra: '${p.role} ${p.org} position',
      ),
    );
  }

  return out;
}

final _index = _buildIndex();

// ── Overlay widget ────────────────────────────────────────────────────────────

class _SearchOverlay extends StatefulWidget {
  const _SearchOverlay({this.initialQuery = ''});
  final String initialQuery;

  @override
  State<_SearchOverlay> createState() => _SearchOverlayState();
}

class _SearchOverlayState extends State<_SearchOverlay> {
  late final TextEditingController _controller;
  String _query = '';
  _Category? _activeFilter; // null = All

  static const _filterLabels = <String, _Category?>{
    'All': null,
    'Projects': _Category.project,
    'Skills': _Category.skill,
    'Academic': _Category.academic,
    'Achievements': _Category.achievement,
    'Certificates': _Category.certificate,
    'Events': _Category.event,
    'Positions': _Category.position,
  };

  @override
  void initState() {
    super.initState();
    _query = widget.initialQuery;
    _controller = TextEditingController(text: _query);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<_SearchResult> get _results {
    final q = _query.trim().toLowerCase();
    return _index.where((r) {
      if (_activeFilter != null && r.category != _activeFilter) return false;
      if (q.isEmpty) return _activeFilter != null;
      return r.title.toLowerCase().contains(q) ||
          r.subtitle.toLowerCase().contains(q) ||
          r.searchExtra.toLowerCase().contains(q);
    }).toList();
  }

  void _navigate(int sectionIndex) {
    Navigator.pop(context);
    navigationBarIndex.value = sectionIndex;
  }

  String _categoryLabel(_Category c) => switch (c) {
    _Category.project => 'Project',
    _Category.skill => 'Skill',
    _Category.academic => 'Academic',
    _Category.achievement => 'Achievement',
    _Category.certificate => 'Certificate',
    _Category.event => 'Event',
    _Category.position => 'Position',
  };

  Color _categoryColor(_Category c) => switch (c) {
    _Category.project => AppColors.accent,
    _Category.skill => const Color(0xFF5DD9C1),
    _Category.academic => const Color(0xFF8BB4FF),
    _Category.achievement => const Color(0xFFFFB74D),
    _Category.certificate => const Color(0xFFD4A8FF),
    _Category.event => const Color(0xFFF9A8C9),
    _Category.position => const Color(0xFF93C5FD),
  };

  @override
  Widget build(BuildContext context) {
    final inset = MediaQuery.viewInsetsOf(context).bottom;
    final results = _results;
    final hasInput = _query.trim().isNotEmpty || _activeFilter != null;

    return GestureDetector(
      onTap: () => Navigator.pop(context),
      behavior: HitTestBehavior.opaque,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: GestureDetector(
          onTap: () {}, // prevent close when tapping inside
          child: AnimatedPadding(
            duration: const Duration(milliseconds: 180),
            padding: EdgeInsets.only(bottom: inset),
            child: Container(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.sizeOf(context).height * 0.82,
              ),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ── Handle ──────────────────────────────────────────────
                  const SizedBox(height: 12),
                  Container(
                    width: 36,
                    height: 4,
                    decoration: BoxDecoration(
                      color: AppColors.border2,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // ── Search field ─────────────────────────────────────────
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: AppColors.surface2,
                        borderRadius: BorderRadius.circular(100),
                        border: Border.all(color: AppColors.border2),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.search, size: 18, color: AppColors.accent),
                          const SizedBox(width: 10),
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              autofocus: true,
                              style: AppTextStyles.bodyMedium(
                                color: const Color(0xFFE8F8F5),
                              ),
                              decoration: InputDecoration(
                                hintText:
                                    'Search projects, skills, achievements…',
                                hintStyle: AppTextStyles.bodyMedium(
                                  color: const Color(0x54E8F8F5),
                                ),
                                border: InputBorder.none,
                                isDense: true,
                              ),
                              onChanged: (v) => setState(() => _query = v),
                            ),
                          ),
                          if (_query.isNotEmpty)
                            GestureDetector(
                              onTap: () {
                                _controller.clear();
                                setState(() => _query = '');
                              },
                              child: const Icon(
                                Icons.close_rounded,
                                size: 16,
                                color: Color(0x73E8F8F5),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // ── Category filter chips ────────────────────────────────
                  SizedBox(
                    height: 32,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      children: _filterLabels.entries
                          .toList()
                          .asMap()
                          .entries
                          .map((entry) {
                            final i = entry.key;
                            final label = entry.value.key;
                            final cat = entry.value.value;
                            final isActive = _activeFilter == cat;
                            return Padding(
                              padding: EdgeInsets.only(
                                right: i < _filterLabels.length - 1 ? 8 : 0,
                              ),
                              child: _FilterChip(
                                label: label,
                                active: isActive,
                                onTap: () =>
                                    setState(() => _activeFilter = cat),
                              ),
                            );
                          })
                          .toList(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(height: 1, color: AppColors.border),

                  // ── Body ────────────────────────────────────────────────
                  Flexible(
                    child: !hasInput
                        ? _IdleBody()
                        : results.isEmpty
                        ? _EmptyBody(query: _query)
                        : ListView.separated(
                            padding: const EdgeInsets.fromLTRB(18, 12, 18, 32),
                            itemCount: results.length,
                            separatorBuilder: (_, __) =>
                                const SizedBox(height: 6),
                            itemBuilder: (_, i) {
                              final r = results[i];
                              return _ResultTile(
                                result: r,
                                label: _categoryLabel(r.category),
                                labelColor: _categoryColor(r.category),
                                onTap: () => _navigate(r.sectionIndex),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ── Filter chip ───────────────────────────────────────────────────────────────

class _FilterChip extends StatelessWidget {
  const _FilterChip({
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
        duration: const Duration(milliseconds: 160),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
        decoration: BoxDecoration(
          color: active ? AppColors.accentDim : Colors.transparent,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(
            color: active
                ? AppColors.accent.withValues(alpha: 0.4)
                : AppColors.border,
          ),
        ),
        child: Text(
          label,
          style: AppTextStyles.mono(
            color: active ? AppColors.accentLight : const Color(0x80E8F8F5),
            size: 10,
            weight: active ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

// ── Idle state ────────────────────────────────────────────────────────────────

class _IdleBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 28, 18, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.travel_explore_outlined,
            size: 38,
            color: AppColors.accent.withValues(alpha: 0.35),
          ),
          const SizedBox(height: 12),
          Text(
            'Search Everything',
            style: AppTextStyles.headingSmall().copyWith(fontSize: 15),
          ),
          const SizedBox(height: 6),
          Text(
            'Projects · Skills · Academic · Achievements · Certificates · Events · Positions',
            style: AppTextStyles.mono(color: const Color(0x54E8F8F5), size: 10),
          ),
        ],
      ),
    );
  }
}

// ── Empty state ───────────────────────────────────────────────────────────────

class _EmptyBody extends StatelessWidget {
  const _EmptyBody({required this.query});
  final String query;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 28, 18, 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.search_off_rounded,
            size: 36,
            color: Color(0x54E8F8F5),
          ),
          const SizedBox(height: 12),
          Text(
            query.isNotEmpty
                ? 'No results for "$query"'
                : 'Nothing in this category',
            style: AppTextStyles.bodyMedium(color: const Color(0x80E8F8F5)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ── Result tile ───────────────────────────────────────────────────────────────

class _ResultTile extends StatelessWidget {
  const _ResultTile({
    required this.result,
    required this.label,
    required this.labelColor,
    required this.onTap,
  });

  final _SearchResult result;
  final String label;
  final Color labelColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.surface2,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.border),
        ),
        child: Row(
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
              child: Icon(result.icon, size: 17, color: AppColors.accent),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result.title,
                    style: AppTextStyles.bodyMedium(
                      color: const Color(0xFFE8F8F5),
                    ).copyWith(fontWeight: FontWeight.w600),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    result.subtitle,
                    style: AppTextStyles.mono(
                      color: const Color(0x73E8F8F5),
                      size: 10,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: labelColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(100),
              ),
              child: Text(
                label,
                style: AppTextStyles.mono(
                  color: labelColor,
                  size: 9,
                  weight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
