import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:lloydportfolio/data/academic/academic_data.dart' as acad;
import 'package:lloydportfolio/data/contact/contact_data.dart' as contact;
import 'package:lloydportfolio/data/credentials/credential_data.dart' as cred;
import 'package:lloydportfolio/data/profile/profile_data.dart' as profile;
import 'package:lloydportfolio/data/projects/project_data.dart' as proj;
import 'package:lloydportfolio/data/skills/skill_data.dart' as skills;

/// Generates a Harvard-style one-page resume PDF for Jhon Lloyd Valencia.
class ResumeBuilder {
  // ── Palette ──────────────────────────────────────────────────────────────
  static const _black = PdfColors.black;
  static const _grey = PdfColor.fromInt(0xFF555555);
  static const _lightGrey = PdfColor.fromInt(0xFF888888);

  // ── Fonts ─────────────────────────────────────────────────────────────────
  static final _serif = pw.Font.times();
  static final _serifBold = pw.Font.timesBold();
  static final _serifItalic = pw.Font.timesItalic();

  // ── Text helpers ──────────────────────────────────────────────────────────
  static pw.TextStyle _h1() => pw.TextStyle(
    font: _serifBold,
    fontSize: 18,
    color: _black,
    letterSpacing: 0.4,
  );

  static pw.TextStyle _sectionHeader() => pw.TextStyle(
    font: _serifBold,
    fontSize: 10,
    color: _black,
    letterSpacing: 1.5,
  );

  static pw.TextStyle _body([double size = 9.5]) =>
      pw.TextStyle(font: _serif, fontSize: size, color: _black);

  static pw.TextStyle _bold([double size = 9.5]) =>
      pw.TextStyle(font: _serifBold, fontSize: size, color: _black);

  static pw.TextStyle _italic([double size = 9]) =>
      pw.TextStyle(font: _serifItalic, fontSize: size, color: _grey);

  static pw.TextStyle _sub([double size = 9]) =>
      pw.TextStyle(font: _serif, fontSize: size, color: _lightGrey);

  // ── Section divider ───────────────────────────────────────────────────────
  static pw.Widget _sectionTitle(String title) {
    return pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.SizedBox(height: 10),
        pw.Text(title, style: _sectionHeader()),
        pw.Divider(color: _black, thickness: 0.6, height: 4),
        pw.SizedBox(height: 4),
      ],
    );
  }

  // ── Education entry ───────────────────────────────────────────────────────
  static pw.Widget _edu({
    required String degree,
    required String school,
    required String period,
    required List<String> bullets,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 5),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(degree, style: _bold()),
              pw.Text(period, style: _body()),
            ],
          ),
          pw.Text(school, style: _italic()),
          ...bullets.map((b) => _bullet(b)),
        ],
      ),
    );
  }

  // ── Project entry ─────────────────────────────────────────────────────────
  static pw.Widget _project({
    required String name,
    required String period,
    required List<String> bullets,
  }) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 5),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(name, style: _bold()),
              pw.Text(period, style: _body()),
            ],
          ),
          ...bullets.map((b) => _bullet(b)),
        ],
      ),
    );
  }

  // ── Bullet point ──────────────────────────────────────────────────────────
  static pw.Widget _bullet(String text) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(left: 10, top: 1),
      child: pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('• ', style: _body()),
          pw.Expanded(child: pw.Text(text, style: _body())),
        ],
      ),
    );
  }

  // ── Skills row ────────────────────────────────────────────────────────────
  static pw.Widget _skillRow(String label, String value) {
    return pw.Padding(
      padding: const pw.EdgeInsets.only(bottom: 2),
      child: pw.RichText(
        text: pw.TextSpan(
          children: [
            pw.TextSpan(text: '$label:  ', style: _bold()),
            pw.TextSpan(text: value, style: _body()),
          ],
        ),
      ),
    );
  }

  // ── Main build ───────────────────────────────────────────────────────────
  static Future<Uint8List> build() async {
    final doc = pw.Document();
    final info = profile.personalInfo;

    // Build contact header line from data
    final emailContact = contact.contacts.firstWhere((c) => c.label == 'Email');
    final phoneContact = contact.contacts.firstWhere((c) => c.label == 'Phone');
    final ghContact = contact.contacts.firstWhere((c) => c.label == 'GitHub');
    final liContact = contact.contacts.firstWhere((c) => c.label == 'LinkedIn');
    final contactLine =
        '${phoneContact.value}  ·  ${emailContact.value}  ·  ${ghContact.url.replaceFirst('https://', '')}  ·  ${liContact.url.replaceFirst('https://', '')}';

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.letter,
        margin: const pw.EdgeInsets.symmetric(horizontal: 54, vertical: 46),
        build: (context) => [
          // ── HEADER ────────────────────────────────────────────────────────
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.center,
            children: [
              pw.Text(info.fullName.toUpperCase(), style: _h1()),
              pw.SizedBox(height: 3),
              pw.Text(
                contactLine,
                style: _sub(8.5),
                textAlign: pw.TextAlign.center,
              ),
              pw.Divider(color: _black, thickness: 0.8, height: 8),
            ],
          ),

          // ── EDUCATION ─────────────────────────────────────────────────────
          _sectionTitle('EDUCATION'),
          for (final e in acad.educationList)
            _edu(
              degree:
                  '${e.degree}${e.field.isNotEmpty && e.degree != 'Elementary' ? ' in ${e.field}' : ''}',
              school: e.institution,
              period: e.duration,
              bullets: [e.details],
            ),

          // ── TECHNICAL SKILLS ──────────────────────────────────────────────
          _sectionTitle('TECHNICAL SKILLS'),
          for (final cat in skills.skillCategories)
            _skillRow(cat.title, cat.skills.join(', ')),
          pw.SizedBox(height: 2),

          // ── PROJECTS ──────────────────────────────────────────────────────
          _sectionTitle('PROJECTS'),
          for (final p in proj.projects.where((p) => p.status != 'In Progress'))
            _project(
              name: '${p.title} — ${p.subtitle.split(' · ').first}',
              period: p.tags.lastWhere(
                (t) => RegExp(r'^\d{4}$').hasMatch(t),
                orElse: () => '',
              ),
              bullets: [
                p.details,
                if (p.sdgs.isNotEmpty)
                  'Aligned with ${p.sdgs.map((s) => s.number).join(', ')}.',
              ],
            ),

          // ── CERTIFICATIONS ────────────────────────────────────────────────
          _sectionTitle('CERTIFICATIONS'),
          for (final c in cred.certificates)
            _bullet('${c.name} — ${c.issuer}, ${c.year}'),
          pw.SizedBox(height: 2),

          // ── LEADERSHIP & ACTIVITIES ───────────────────────────────────────
          _sectionTitle('LEADERSHIP & ACTIVITIES'),
          _bullet('President, MSEUF DOST Scholars\' Guild'),
          for (final a in acad.achievementsList.where(
            (a) =>
                a.category != 'Scholarship' ||
                a.title.contains('DOST') ||
                a.title.contains('DataCamp'),
          ))
            _bullet('${a.category}, ${a.event} (${a.period})'),
        ],
      ),
    );

    return doc.save();
  }
}
