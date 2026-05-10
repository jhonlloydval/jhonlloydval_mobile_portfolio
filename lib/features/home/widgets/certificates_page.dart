import 'package:flutter/material.dart';
import 'package:lloydportfolio/core/constants/app_colors.dart';
import 'package:lloydportfolio/core/theme/font_styles.dart';
import 'package:lloydportfolio/data/credentials/credential_data.dart' as cred;
import 'package:lloydportfolio/data/credentials/credential_model.dart';

// ─── Page ─────────────────────────────────────────────────────────────────────

class CertificatesPage extends StatefulWidget {
  const CertificatesPage({super.key});

  @override
  State<CertificatesPage> createState() => _CertificatesPageState();
}

class _CertificatesPageState extends State<CertificatesPage> {
  int _tab = 0;

  @override
  Widget build(BuildContext context) {
    final isCerts = _tab == 0;
    final count = isCerts ? cred.certificates.length : cred.events.length;
    final subtitle = isCerts ? '$count credentials' : '$count events attended';

    return Scaffold(
      backgroundColor: AppColors.bg,
      body: SafeArea(
        child: Column(
          children: [
            // ── Header ────────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 14, 20, 0),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.surface3,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.border2),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 15,
                        color: Color(0xCCE8F8F5),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Credentials',
                          style: AppTextStyles.headingMedium().copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        Text(
                          subtitle,
                          style: AppTextStyles.mono(
                            color: const Color(0x54E8F8F5),
                            size: 10,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // ── Divider ───────────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 1,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      AppColors.accent.withValues(alpha: 0.2),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            // ── Segmented control ─────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                height: 40,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    _TabPill(
                      label: 'Certificates',
                      icon: Icons.workspace_premium_rounded,
                      active: _tab == 0,
                      onTap: () => setState(() => _tab = 0),
                    ),
                    const SizedBox(width: 4),
                    _TabPill(
                      label: 'Events',
                      icon: Icons.groups_rounded,
                      active: _tab == 1,
                      onTap: () => setState(() => _tab = 1),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            // ── List ──────────────────────────────────────────────────────
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child: isCerts
                    ? ListView.separated(
                        key: const ValueKey('certs'),
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                        itemCount: cred.certificates.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 12),
                        itemBuilder: (context, i) =>
                            CertCard(cert: cred.certificates[i]),
                      )
                    : ListView.separated(
                        key: const ValueKey('events'),
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
                        itemCount: cred.events.length,
                        separatorBuilder: (_, _) => const SizedBox(height: 12),
                        itemBuilder: (context, i) =>
                            _EventCard(event: cred.events[i]),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Tab pill ─────────────────────────────────────────────────────────────────

class _TabPill extends StatelessWidget {
  const _TabPill({
    required this.label,
    required this.icon,
    required this.active,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            gradient: active
                ? LinearGradient(
                    colors: [AppColors.accentDeep, AppColors.accent],
                  )
                : null,
            borderRadius: BorderRadius.circular(10),
          ),
          alignment: Alignment.center,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                icon,
                size: 13,
                color: active ? Colors.white : const Color(0x54E8F8F5),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: AppTextStyles.mono(
                  color: active ? Colors.white : const Color(0x54E8F8F5),
                  size: 11,
                  weight: active ? FontWeight.w600 : FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CertCard extends StatelessWidget {
  const CertCard({super.key, required this.cert});

  final CertData cert;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.accentDeep, AppColors.accentSoft],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(13),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: const Icon(
              Icons.workspace_premium_rounded,
              size: 22,
              color: Colors.white,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cert.category,
                  style: AppTextStyles.mono(
                    color: AppColors.accent,
                    size: 9,
                    weight: FontWeight.w600,
                  ).copyWith(letterSpacing: 0.8),
                ),
                const SizedBox(height: 3),
                Text(
                  cert.name,
                  style: AppTextStyles.bodyLarge(
                    color: const Color(0xFFE8F8F5),
                  ).copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  '${cert.issuer} · ${cert.year}',
                  style: AppTextStyles.mono(
                    color: const Color(0x54E8F8F5),
                    size: 10,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.accentDim,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              cert.year,
              style: AppTextStyles.mono(
                color: AppColors.accentLight,
                size: 10,
                weight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Event card ───────────────────────────────────────────────────────────────

class _EventCard extends StatelessWidget {
  const _EventCard({required this.event});

  final EventData event;

  static IconData _iconFor(String type) => switch (type) {
    'WEBINAR' => Icons.videocam_rounded,
    'WORKSHOP' => Icons.build_rounded,
    'CONFERENCE' => Icons.cell_tower_rounded,
    'COMPETITION' => Icons.emoji_events_rounded,
    'TRAINING' => Icons.model_training_rounded,
    'SCHOLARSHIP' => Icons.school_rounded,
    _ => Icons.groups_rounded,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border2),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.accentSoft, AppColors.accentDeep],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(13),
              boxShadow: [
                BoxShadow(
                  color: AppColors.accent.withValues(alpha: 0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(_iconFor(event.type), size: 20, color: Colors.white),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.type,
                  style: AppTextStyles.mono(
                    color: AppColors.accentLight,
                    size: 9,
                    weight: FontWeight.w600,
                  ).copyWith(letterSpacing: 0.8),
                ),
                const SizedBox(height: 3),
                Text(
                  event.name,
                  style: AppTextStyles.bodyLarge(
                    color: const Color(0xFFE8F8F5),
                  ).copyWith(fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  '${event.organizer} · ${event.year}',
                  style: AppTextStyles.mono(
                    color: const Color(0x54E8F8F5),
                    size: 10,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.accentDim,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Text(
              event.year,
              style: AppTextStyles.mono(
                color: AppColors.accentLight,
                size: 10,
                weight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
