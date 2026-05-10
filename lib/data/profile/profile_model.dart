class PersonalInfo {
  final String name;
  final String fullName;
  final String title;
  final String location;
  final String availabilityStatus;
  final String profileImagePath;

  const PersonalInfo({
    required this.name,
    required this.fullName,
    required this.title,
    required this.location,
    required this.availabilityStatus,
    required this.profileImagePath,
  });
}

class BioEntry {
  final String title;
  final String body;

  const BioEntry({required this.title, required this.body});
}

class PositionEntry {
  final String role;
  final String org;
  final String iconName;

  const PositionEntry({
    required this.role,
    required this.org,
    required this.iconName,
  });
}
