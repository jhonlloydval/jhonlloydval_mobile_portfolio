import 'package:flutter/widgets.dart';

class FeatureItem {
  final String title;
  final String description;

  const FeatureItem(this.title, this.description);
}

class SdgItem {
  final String number;
  final String label;
  final String description;

  const SdgItem(this.number, this.label, this.description);
}

class ProjectItem {
  final String title;
  final String subtitle;
  final String details;
  final List<String> tags;
  final String status;
  final IconData icon;
  final String? imagePath;
  final List<String> imagePaths;
  final List<FeatureItem> longDescription;
  final List<String> whyItMatters;
  final List<SdgItem> sdgs;

  const ProjectItem({
    required this.title,
    required this.subtitle,
    required this.details,
    required this.tags,
    required this.status,
    required this.icon,
    this.imagePath,
    this.imagePaths = const [],
    this.longDescription = const [],
    this.whyItMatters = const [],
    this.sdgs = const [],
  });
}
