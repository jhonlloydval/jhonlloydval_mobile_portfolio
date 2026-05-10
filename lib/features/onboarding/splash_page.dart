import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:lloydportfolio/core/constants/app_colors.dart';
import 'package:lloydportfolio/core/theme/font_styles.dart';
import 'package:lloydportfolio/features/home/presentation/main_page.dart';
import 'package:lloydportfolio/notifiers.dart';
import 'package:url_launcher/url_launcher.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);

    return ValueListenableBuilder<int>(
      valueListenable: themeIndex,
      builder: (context, _, __) {
        return Scaffold(
          backgroundColor: AppColors.bg,
          body: Stack(
            children: [
              buildBackground(size),
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Spacer(flex: 3),
                      buildBadge(),
                      const SizedBox(height: 20),
                      buildHeader(),
                      const SizedBox(height: 16),
                      buildSubtitle(),
                      const SizedBox(height: 8),
                      buildDivider(),
                      const SizedBox(height: 20),
                      buildSectionPills(),
                      const Spacer(flex: 4),
                      buildButtons(context),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// ── Background ───────────────────────────────────────────────────────────────

Widget buildBackground(Size size) {
  return Stack(
    children: [
      Positioned(
        top: -size.height * 0.12,
        right: -size.width * 0.25,
        child: _glowOrb(
          size.width * 0.85,
          AppColors.accentDeep.withValues(alpha: 0.35),
        ),
      ),
      Positioned(
        bottom: size.height * 0.1,
        left: -size.width * 0.3,
        child: _glowOrb(
          size.width * 0.7,
          AppColors.accent.withValues(alpha: 0.18),
        ),
      ),
      Positioned.fill(child: CustomPaint(painter: _GridPainter())),
    ],
  );
}

// ── Badge ────────────────────────────────────────────────────────────────────

Widget buildBadge() {
  return Container(
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
    decoration: BoxDecoration(
      color: AppColors.accentSurface,
      borderRadius: BorderRadius.circular(100),
      border: Border.all(color: AppColors.accent.withValues(alpha: 0.4)),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 6,
          height: 6,
          decoration: BoxDecoration(
            color: AppColors.accentLight,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.accentLight.withValues(alpha: 0.8),
                blurRadius: 6,
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Text(
          'AVAILABLE FOR HIRE',
          style: AppTextStyles.eyebrow(color: AppColors.accentLight),
        ),
      ],
    ),
  );
}

// ── Header ───────────────────────────────────────────────────────────────────

Widget buildHeader() {
  return Text(
    'Jhon Lloyd\nMontalbo\nValencia',
    style: AppTextStyles.displayName(),
  );
}

// ── Subtitle ─────────────────────────────────────────────────────────────────

Widget buildSubtitle() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Computer Science Portfolio', style: AppTextStyles.subtitle()),
      const SizedBox(height: 4),
      Text(
        'BS Computer Science · MSEUF · Batangas',
        style: AppTextStyles.mono(color: const Color(0x80E8F8F5), size: 10),
      ),
    ],
  );
}

// ── Divider ──────────────────────────────────────────────────────────────────

Widget buildDivider() {
  return Row(
    children: [
      Container(
        width: 48,
        height: 2,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [AppColors.accent, AppColors.accentLight],
          ),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
      const SizedBox(width: 8),
      Container(
        width: 8,
        height: 2,
        color: AppColors.accentLight.withValues(alpha: 0.4),
      ),
    ],
  );
}

// ── Section pills ─────────────────────────────────────────────────────────────

Widget buildSectionPills() {
  const pills = [
    (Icons.person_outline, 'Profile'),
    (Icons.school_outlined, 'Academic'),
    (Icons.code_outlined, 'Skills'),
    (Icons.folder_outlined, 'Projects'),
    (Icons.mail_outline, 'Contact'),
    (Icons.article_outlined, 'Certificates'),
  ];
  return Wrap(
    spacing: 8,
    runSpacing: 8,
    children: pills.map((p) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.accentSurface,
          borderRadius: BorderRadius.circular(100),
          border: Border.all(color: AppColors.accent.withValues(alpha: 0.22)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(p.$1, size: 12, color: AppColors.accentLight),
            const SizedBox(width: 5),
            Text(
              p.$2,
              style: AppTextStyles.mono(color: AppColors.accentLight, size: 10),
            ),
          ],
        ),
      );
    }).toList(),
  );
}

// ── Buttons ──────────────────────────────────────────────────────────────────

Widget buildButtons(BuildContext context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      _SplashButton(
        label: 'Enter Portfolio',
        icon: Icons.arrow_forward_rounded,
        primary: true,
        onPressed: () {
          Navigator.of(context).push(
            PageRouteBuilder(
              transitionDuration: const Duration(milliseconds: 300),
              reverseTransitionDuration: const Duration(milliseconds: 200),
              pageBuilder: (_, __, ___) => const HomePage(),
              transitionsBuilder: (_, animation, __, child) {
                final fade = CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutCubic,
                );
                final slide = Tween<Offset>(
                  begin: const Offset(0, 0.04),
                  end: Offset.zero,
                ).animate(fade);
                return FadeTransition(
                  opacity: fade,
                  child: SlideTransition(position: slide, child: child),
                );
              },
            ),
          );
        },
      ),
      const SizedBox(height: 14),
      _SplashButton(
        label: 'Get In Touch',
        icon: Icons.mail_outline_rounded,
        primary: false,
        onPressed: () async {
          final uri = Uri.parse('mailto:jhonlloydval@gmail.com');
          if (!await launchUrl(uri)) {
            await launchUrl(
              Uri.parse(
                'https://mail.google.com/mail/?view=cm&to=jhonlloydval@gmail.com',
              ),
              mode: LaunchMode.externalApplication,
            );
          }
        },
      ),
    ],
  );
}

// ── Shared helpers ────────────────────────────────────────────────────────────

Widget _glowOrb(double size, Color color) => Container(
  width: size,
  height: size,
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    gradient: RadialGradient(colors: [color, Colors.transparent]),
  ),
);

// ── Button widget ─────────────────────────────────────────────────────────────

class _SplashButton extends StatefulWidget {
  const _SplashButton({
    required this.label,
    required this.icon,
    required this.primary,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final bool primary;
  final VoidCallback onPressed;

  @override
  State<_SplashButton> createState() => _SplashButtonState();
}

class _SplashButtonState extends State<_SplashButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onPressed();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 1.0, end: _pressed ? 0.97 : 1.0),
        duration: const Duration(milliseconds: 120),
        builder: (_, scale, child) =>
            Transform.scale(scale: scale, child: child),
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            gradient: widget.primary
                ? LinearGradient(
                    colors: [AppColors.accentDeep, AppColors.accent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  )
                : null,
            color: widget.primary ? null : AppColors.surface2,
            borderRadius: BorderRadius.circular(14),
            border: widget.primary
                ? null
                : Border.all(color: AppColors.border2, width: 1.5),
            boxShadow: widget.primary
                ? [
                    BoxShadow(
                      color: AppColors.accent.withValues(alpha: 0.45),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (!widget.primary) ...[
                Icon(widget.icon, color: Colors.white70, size: 18),
                const SizedBox(width: 10),
              ],
              Text(
                widget.label,
                style: widget.primary
                    ? AppTextStyles.buttonPrimary()
                    : AppTextStyles.buttonOutlined(color: Colors.white70),
              ),
              if (widget.primary) ...[
                const SizedBox(width: 10),
                Icon(widget.icon, color: Colors.white, size: 18),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// ── Grid painter ──────────────────────────────────────────────────────────────

class _GridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const spacing = 28.0;
    final paint = Paint()..strokeWidth = 1;
    final cols = (size.width / spacing).ceil();
    final rows = (size.height / spacing).ceil();

    for (int r = 0; r <= rows; r++) {
      for (int c = 0; c <= cols; c++) {
        final x = c * spacing;
        final y = r * spacing;
        final dx = (x - size.width / 2).abs() / size.width;
        final dy = (y - size.height / 2).abs() / size.height;
        final dist = math.sqrt(dx * dx + dy * dy);
        final opacity = (0.025 * (1 - dist)).clamp(0.004, 0.025);
        canvas.drawCircle(
          Offset(x, y),
          1.2,
          paint..color = Colors.white.withValues(alpha: opacity),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
