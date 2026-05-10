import 'dart:io';

import 'package:flutter/material.dart';
import 'package:lloydportfolio/core/constants/app_colors.dart';
import 'package:lloydportfolio/core/theme/font_styles.dart';
import 'package:lloydportfolio/data/contact/contact_data.dart' as contact_data;
import 'package:lloydportfolio/data/contact/contact_model.dart';
import 'package:lloydportfolio/features/home/widgets/resume_builder.dart';
import 'package:lloydportfolio/features/home/widgets/sticky_title_bar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> {
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
    const contacts = contact_data.contacts;

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
                  'Get In\nTouch',
                  style: AppTextStyles.headingLarge().copyWith(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    height: 1.05,
                  ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                'Feel free to reach out via any channel',
                style: AppTextStyles.bodyMedium(color: const Color(0x54E8F8F5)),
              ),
              const SizedBox(height: 22),
              ...contacts.map((contact) => _ContactCard(contact: contact)),
              const SizedBox(height: 22),
              _DownloadCV(),
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
            title: 'Get In Touch',
            subtitle: 'Feel free to reach out',
          ),
        ),
      ],
    );
  }
}

class _ContactCard extends StatelessWidget {
  final ContactItem contact;

  const _ContactCard({required this.contact});

  Future<void> _openContact(BuildContext context) async {
    final uri = Uri.parse(contact.url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Could not open link.')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Material(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () => _openContact(context),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColors.accentDeep, AppColors.accentSoft],
                    ),
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Icon(contact.icon, color: Colors.white, size: 24),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        contact.label.toUpperCase(),
                        style: AppTextStyles.mono(
                          color: const Color(0x54E8F8F5),
                          size: 10,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        contact.value,
                        style: AppTextStyles.bodyLarge(
                          color: const Color(0xFFE8F8F5),
                        ).copyWith(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_outward_rounded,
                  color: AppColors.accent,
                  size: 18,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DownloadCV extends StatelessWidget {
  Future<void> _openResume(BuildContext context) async {
    try {
      final bytes = await ResumeBuilder.build();
      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/JhonLloyd_Valencia_Resume.pdf');
      await file.writeAsBytes(bytes, flush: true);

      final ok = await launchUrl(
        Uri.file(file.path),
        mode: LaunchMode.externalApplication,
      );
      if (!ok && context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open resume file.')),
        );
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Resume generation failed.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.accentDeep.withValues(alpha: 0.36),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Material(
          color: Colors.transparent,
          child: Ink(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [AppColors.accentDeep, AppColors.accent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: InkWell(
              onTap: () => _openResume(context),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.download_rounded, color: Colors.white),
                    const SizedBox(width: 12),
                    Text(
                      'Download Resume',
                      style: AppTextStyles.buttonPrimary(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
