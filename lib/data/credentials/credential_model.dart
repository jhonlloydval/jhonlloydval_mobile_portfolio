class CertData {
  final String name;
  final String issuer;
  final String year;
  final String category;

  const CertData({
    required this.name,
    required this.issuer,
    required this.year,
    required this.category,
  });
}

class EventData {
  final String name;
  final String organizer;
  final String year;
  final String
  type; // COMPETITION / SCHOLARSHIP / TRAINING / SEMINAR / WEBINAR / WORKSHOP / CONFERENCE

  const EventData({
    required this.name,
    required this.organizer,
    required this.year,
    required this.type,
  });
}
