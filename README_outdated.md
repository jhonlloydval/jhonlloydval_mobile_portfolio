# Lloyd Portfolio — Flutter App

A polished, interactive personal portfolio built with Flutter. Designed for mobile-first presentation of identity, projects, skills, academic background, certificates, and contact — all wrapped in a themeable dark UI with smooth animations.

---

## Screenshots

> _Coming soon — add simulator/device screenshots here_

---

## Features

- **Animated Onboarding** — First-launch experience with branded intro screens
- **5-Section Navigation** — Floating nav bar with animated active indicator
  - **Profile** — Identity card, bio, positions, stats, quick links
  - **Academic** — Segmented view for academic background and competitions
  - **Skills** — Technology tags organized by category
  - **Projects** — Pseudo-infinite carousel with synced detail panel
  - **Contact** — Social and contact links
- **Full Introduction Sheet** — Bottom sheet with hero photo, bio sections, and availability status
- **Credentials Page** — Two-tab page: `Certificates` and `Events` (seminars, webinars, workshops, conferences)
- **5-Palette Theme Switcher** — Live, persistent theme switching via an inline popover
  - **Default** (Teal · `#00C996`)
  - **Ember** (Amber-Red · `#F0CB35`)
  - **Orchid** (Purple · `#AD5389`)
  - **Storm** (Slate · `#BDC3C7`)
  - **Citrine** (Lime · `#F1F2B5`)
- **Theme Persistence** — Selected theme saved to device via `shared_preferences`
- **Atmosphere Background** — Ambient animated blobs that respond to the active theme

---

## Tech Stack

| Layer | Technology |
|---|---|
| Framework | Flutter `^3.11.4` / Dart `^3.11.4` |
| Typography | `google_fonts` — DM Sans, Poppins, DM Mono |
| Persistence | `shared_preferences ^2.3.3` |
| State | `ValueNotifier` (lightweight, no external state manager) |
| Architecture | Feature-first folder structure |
| Platforms | Android · iOS · macOS · Web · Linux · Windows |

---

## Project Structure

```
lib/
├── main.dart                    # Entry point — initializes theme before runApp
├── app.dart                     # MaterialApp + ValueListenableBuilder for theme
├── notifiers.dart               # Global ValueNotifiers: navigationBarIndex, themeIndex
├── core/
│   ├── constants/
│   │   └── app_colors.dart      # Mutable color tokens — updated by updateFromPalette()
│   ├── theme/
│   │   ├── app_theme.dart       # 5 AppThemePalette presets + AppThemePreset enum
│   │   └── font_styles.dart     # AppTextStyles helpers (headings, body, mono)
│   └── widgets/                 # Shared utility widgets
└── features/
    ├── onboarding/              # Onboarding flow
    ├── home/
    │   ├── presentation/
    │   │   └── main_page.dart   # Home shell — IndexedStack + floating nav + atmosphere
    │   └── widgets/
    │       ├── profile_section.dart      # Profile, positions, stats, theme picker
    │       ├── intro_sheet.dart          # Full introduction bottom sheet
    │       ├── certificates_page.dart    # Certificates + Events tabbed page
    │       ├── academic_section.dart     # Academic background + competitions slider
    │       ├── skills_section.dart       # Skills tag grid
    │       ├── projects_section.dart     # Project carousel
    │       └── contact_section.dart      # Contact links
    └── auth/
```

---

## Getting Started

### Prerequisites

- Flutter SDK `>=3.11.4` — [Install Flutter](https://docs.flutter.dev/get-started/install)
- Dart SDK `>=3.11.4` (bundled with Flutter)
- A connected device or emulator

### Installation

```bash
# 1. Clone the repository
git clone https://github.com/jhonlloydval/lloydportfolio.git
cd lloydportfolio

# 2. Install dependencies
flutter pub get

# 3. Run the app
flutter run
```

> **Note:** After adding `shared_preferences` for the first time or switching platforms, run `flutter clean && flutter pub get` before `flutter run` to ensure native plugins are registered correctly.

### Build

```bash
# Android APK
flutter build apk --release

# iOS (requires macOS + Xcode)
flutter build ios --release

# Web
flutter build web --release

# macOS
flutter build macos --release
```

---

## Customization

### Updating Personal Info

| What | Where |
|---|---|
| Name, bio, availability | `lib/features/home/widgets/profile_section.dart` — `_IntroPhotoCard` |
| Full introduction text | `lib/features/home/widgets/intro_sheet.dart` — `_BioSection` entries |
| Positions / roles | `profile_section.dart` — `_PositionItem` list |
| Stat cards (projects, experience, skills) | `profile_section.dart` — `_StatCard` values |
| Certificates | `lib/features/home/widgets/certificates_page.dart` — `_certificates` list |
| Events / seminars | `certificates_page.dart` — `_events` list |
| Projects | `lib/features/home/widgets/projects_section.dart` — `projects` list |
| Profile photo | Replace `assets/images/jhon_profile.jpg` |

### Adding a Theme

1. Add a new value to `AppThemePreset` in `lib/core/theme/app_theme.dart`
2. Create a new `AppThemePalette` const with your color tokens
3. Add it to `AppThemePalette.all`

---

## Dependencies

```yaml
dependencies:
  google_fonts: ^6.2.1       # DM Sans · Poppins · DM Mono
  shared_preferences: ^2.3.3 # Theme persistence
```

---

## License

This project is personal and not licensed for redistribution. All content (name, bio, credentials) belongs to **Jhon Lloyd Montalbo Valencia**.

---

<p align="center">Built with Flutter · Designed by Jhon Lloyd Valencia</p>

