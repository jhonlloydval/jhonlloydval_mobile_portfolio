import 'package:flutter/widgets.dart';

class ContactItem {
  final String label;
  final String value;
  final IconData icon;
  final String url;

  const ContactItem({
    required this.label,
    required this.value,
    required this.icon,
    required this.url,
  });
}
