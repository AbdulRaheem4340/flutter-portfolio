# Flutter Portfolio

A retro-terminal themed single-page portfolio for **Abdul Raheem**, a Flutter developer. The site is built entirely with Flutter Web and combines a developer-console aesthetic with smooth, scroll-driven animations.

> Live demo: [abdul-raheem-portfolio.web.app](https://abdul-raheem-portfolio.web.app)

## About

This portfolio showcases projects built with Flutter, Firebase, AI APIs, maps, and complex custom UI. It is fully responsive and works across desktop and mobile browsers.

The design uses a retro-terminal visual language: scanlines, film grain, glitch tears, monospace type, and terminal-style status lines.

## Features

- Animated hero section with typewriter/decrypt text and terminal status lines
- Retro effects built with `CustomPainter` and `ClipPath` (scanlines, grain, glitch tear)
- Sticky navigation bar with smooth scroll-to-section
- Responsive mobile drawer navigation
- Scroll-reveal and staggered entrance animations
- About, tech stack, projects, contact, and terminal footer sections
- Project cards with phone mockups, technology badges, view-code and demo-request actions
- External links handled with `url_launcher` (email, GitHub, LinkedIn)

## Tech Stack

- **Flutter / Dart** — application framework
- **GetX** — state management and navigation
- **flutter_animate** — declarative animations
- **google_fonts** — Space Grotesk, Inter, and JetBrains Mono
- **url_launcher** — external links and email
- **visibility_detector** — scroll-triggered reveals
- **CustomPainter / ClipPath** — glitch, grain, and scanline effects
- **Firebase Hosting** — deployment

## Project Structure

```
lib/
  main.dart              # App entry point and theme setup
  home_page.dart         # Home page, controller, navbar, hero, mobile drawer
  sections.dart          # About, tech stack, contact, and footer sections
  project_section.dart   # Project data, cards, and phone mockups
  theme.dart             # Colors, typography, and shared styles
  scroll_reveal.dart     # Scroll-triggered reveal animations
  typewitter_text.dart   # Typewriter text animation
  glitch_text.dart       # Glitch text effect
  clippers.dart          # Custom clip paths
  grain_painter.dart     # Film grain overlay painter
  scanline_painter.dart  # Scanline overlay painter
  launcher_helper.dart   # Email and URL launch helpers
assets/                  # Project screenshots
test/                    # Unit tests
web/                     # Web entry point and manifest
```

## Getting Started

### Prerequisites

- Flutter 3.13 or newer
- Dart 3.13 or newer
- Chrome (for running the web target)

### Run locally

```bash
git clone https://github.com/AbdulRaheem4340/flutter-portfolio.git
cd flutter-portfolio
flutter pub get
flutter run -d chrome
```

### Analyze and test

```bash
flutter analyze
flutter test
```

## Build and Deploy

Build the release web bundle:

```bash
flutter build web --release
```

Deploy to Firebase Hosting (project and site are configured in `.firebaserc` and `firebase.json`):

```bash
firebase deploy --only hosting
```

The output is generated in `build/web`.

## Featured Projects

| Project | Description | Stack |
| --- | --- | --- |
| [AI Interview Coach](https://github.com/AbdulRaheem4340/AI-Interview-Coach) | Voice-based mock interviews with real-time transcription and AI feedback. | Gemini, Voice, Riverpod, Hive, MVVM |
| [OneThing - Deep Focus](https://github.com/AbdulRaheem4340/OneThing) | Solo focus sessions and real-time multiplayer focus rooms. | Firebase, GetX, CustomPainter |
| [Hostel Finder](https://github.com/AbdulRaheem4340/hoster-finder) | Dual-role hostel discovery platform with live map search and owner dashboard. | OpenStreetMap, Firebase, GetX |
| [AI Finance Coach](https://github.com/AbdulRaheem4340/finance-coach-flutter) | Expense tracking, budgets, AI guidance, and local analytics dashboards. | Riverpod, Hive, OpenRouter, FL Chart |
| [Quiz Master](https://github.com/AbdulRaheem4340/quiz-master) | Full-stack quiz platform with authentication and global leaderboards. | Firebase Auth, Firestore, GetX |
| [AI Chat Assistant](https://github.com/AbdulRaheem4340/chat_app) | Real-time AI chat with persistent local history and responsive UI. | AI API, Local Storage |

## Contact

- **Email:** ar4942876@gmail.com
- **GitHub:** [github.com/AbdulRaheem4340](https://github.com/AbdulRaheem4340/)
- **LinkedIn:** [linkedin.com/in/abdul-raheem-7b0486370](https://www.linkedin.com/in/abdul-raheem-7b0486370)

## License

Personal project. Content and design © Abdul Raheem.

# Developer 

Abdul Raheem
