// academic_data.dart
import 'package:lloydportfolio/data/academic/academic_model.dart';

const educationList = <EducationEntry>[
  EducationEntry(
    degree: 'Bachelor of Science',
    field: 'Computer Science',
    institution: 'Manuel S. Enverga University Foundation (MSEUF)',
    duration: '2023 – Present',
    details:
        'DOST-SEI Merit Scholar (Batch 2023). Focused on software engineering, algorithms, data structures, and mobile development.',
  ),
  EducationEntry(
    degree: 'Senior High School – STEM Strand',
    field: 'Science, Technology, Engineering & Mathematics',
    institution: 'Quezon National High School',
    duration: '2021 – 2023',
    details: 'Graduated With High Honors.',
  ),
  EducationEntry(
    degree: 'Junior High School – STE Program',
    field: 'Science, Technology & Engineering',
    institution: 'Quezon National High School',
    duration: '2017 – 2021',
    details: 'Graduated With High Honors.',
  ),
  EducationEntry(
    degree: 'Elementary',
    field: 'Primary Education',
    institution: 'One in Christ Church School of Lucena',
    duration: 'Graduated 2017',
    details: 'Batch Valedictorian.',
  ),
];

const achievementsList = <AchievementEntry>[
  // ── Scholarships ──────────────────────────────────────────────────────────
  AchievementEntry(
    title: 'DOST-SEI Undergraduate Scholar',
    category: 'Scholarship',
    event: 'DOST-SEI Scholarship Program – Batch 2023',
    period: '2023–Present',
    summary:
        'Merit-based scholar under the Department of Science and Technology – Science Education Institute (DOST-SEI), supporting outstanding students pursuing BS Computer Science.',
  ),
  AchievementEntry(
    title: 'MSEUF University Scholar',
    category: 'Scholarship',
    event: 'Enverga University Scholarship Grant',
    period: '2025–2026',
    summary:
        'Achieved a General Weighted Average of 1.24, qualifying for the MSEUF University Scholarship Grant with full tuition fee subsidy.',
  ),
  AchievementEntry(
    title: 'START × DataCamp Donates Scholarship',
    category: 'Scholarship',
    event: 'START DOST – DataCamp Premium Scholar',
    period: '2025',
    summary:
        'Selected as a DataCamp Premium Scholar under the START (Scholars Transforming Advancement and Research for Technology) × DataCamp Donates program, gaining full access to DataCamp\'s premium data science curriculum.',
  ),
  // ── Recognition ───────────────────────────────────────────────────────────
  AchievementEntry(
    title: 'MSEUF Dean\'s Lister',
    category: 'Recognition',
    event: 'Dean\'s List – College of Computing & Multimedia Studies',
    period: '2025–2026',
    summary:
        'Achieved a General Weighted Average of 1.24, earning a place on the Dean\'s List for academic excellence.',
  ),
  AchievementEntry(
    title: 'DOST-SEI Scholars Leadership Conference',
    category: 'Delegate',
    event: 'SLC – Quezon Province',
    period: '2026',
    summary:
        'Selected as a delegate to the DOST-SEI Scholars\' Leadership Conference, representing the province in leadership and technology-focused sessions.',
  ),
  // ── Competitions ──────────────────────────────────────────────────────────
  AchievementEntry(
    title: 'CodeChum Programming Challenge S2',
    category: 'Competition',
    event: 'CodeChum National Programming Challenge – Group Stage',
    period: '2025',
    summary:
        'Reached the Group Stage of the CodeChum National Programming Challenge Season 2, competing against universities nationwide in algorithmic problem solving.',
  ),
  AchievementEntry(
    title: 'National AI Prompt Design Challenge',
    category: 'Competition',
    event: 'NAIPDC – Team S207 (Straits Interactive / AAP)',
    period: '2025',
    summary:
        'Competed in the first nationwide AI competition in the Philippines focused on no-code generative AI app design, held June 17–20, 2025. Completed the pre-event Prompt Engineering Bootcamp and represented Team S207 in building an AI-powered solution using prompt engineering techniques.',
  ),
  AchievementEntry(
    title: 'iSite Python Programming Challenge',
    category: 'Competition',
    event: 'iSite Python Coding Competition – MSEUF',
    period: '2026',
    summary:
        'Participated in the iSite Python Programming Challenge, competing in algorithmic and applied Python problem solving.',
  ),
  // ── Bootcamps ─────────────────────────────────────────────────────────────
  AchievementEntry(
    title: 'openIT Data Science Bootcamp',
    category: 'Bootcamp',
    event: 'openIT Data Science Bootcamp – MSEUF',
    period: '2026',
    summary:
        'Completed the openIT Data Science Bootcamp, a hands-on training program covering data science fundamentals, machine learning, and AI application development. Culminated in the Haive capstone project — a modular GenAI tools platform built with Python, Streamlit, and Ollama.',
  ),
  AchievementEntry(
    title: 'NAIPDC Prompt Engineering Bootcamp',
    category: 'Bootcamp',
    event: 'National AI Prompt Design Challenge – Pre-Event Bootcamp',
    period: '2025',
    summary:
      'Completed the NAIPDC Prompt Engineering Bootcamp, covering language models, prompt design principles, AI hallucinations, and effective communication with generative AI systems. Organized by Straits Interactive and the Analytics and AI Association of the Philippines (AAP).',
  ),
];