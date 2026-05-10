class EducationEntry {
  final String degree;
  final String field;
  final String institution;
  final String duration;
  final String details;

  const EducationEntry({
    required this.degree,
    required this.field,
    required this.institution,
    required this.duration,
    required this.details,
  });
}

class AchievementEntry {
  final String title;
  final String category;
  final String event;
  final String period;
  final String summary;

  const AchievementEntry({
    required this.title,
    required this.category,
    required this.event,
    required this.period,
    required this.summary,
  });
}
