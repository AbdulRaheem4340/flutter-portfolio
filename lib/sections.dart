import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_portfolio/launcher_helper.dart';

import 'theme.dart';
import 'scroll_reveal.dart';

// =========================================================
// ABOUT
// =========================================================
class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppTheme.bgOffWhite,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ScrollReveal(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "I'm Abdul Raheem — a Flutter developer who builds apps that actually solve problems.",
                  style: AppTheme.heading(context)
                      .copyWith(fontSize: 32, height: 1.25),
                ),
                const SizedBox(height: 24),
                Text(
"I'm early in my journey, but I don't ship toy apps. I've built AI-powered tools, "
    "real-time multiplayer experiences, map-based platforms, and complex custom UIs "
    "with CustomPainter. I care about clean architecture, craft, and the small details "
    "that make an app feel finished.\n\n"
    "Currently a Data Science student looking for a Flutter internship where I can "
    "learn from experienced developers, contribute to real production work, and keep growing.",
                  style: AppTheme.body(context)
                      .copyWith(fontSize: 17, height: 1.7),
                ),
                const SizedBox(height: 32),
                _primaryButton(
                  context,
                  "LET'S TALK →",
                  () => LaunchHelpers.openEmail(context: context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// =========================================================
// TECH STACK
// =========================================================
class TechStackSection extends StatelessWidget {
  const TechStackSection({super.key});

  @override
  Widget build(BuildContext context) {
    final techs = [
      'Flutter',
      'Dart',
      'Firebase',
      'Riverpod',
      'GetX',
      'Hive',
      'Gemini API',
      'OpenRouter',
      'OpenStreetMap',
      'Dio',
      'FL Chart',
      'CustomPainter',
      'GoRouter',
      'Firestore',
      'REST APIs',
      'MVVM',
    ];

    return Container(
      width: double.infinity,
      color: AppTheme.bgAlt,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ScrollReveal(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                
                    Text(
                      'Tools I build with.',
                      style: AppTheme.heading(context).copyWith(fontSize: 32),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: techs.asMap().entries.map((entry) {
                  return StaggerReveal(
                    index: entry.key,
                    child: _TechBadge(label: entry.value),
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TechBadge extends StatefulWidget {
  final String label;
  const _TechBadge({required this.label});

  @override
  State<_TechBadge> createState() => _TechBadgeState();
}

class _TechBadgeState extends State<_TechBadge> {
  bool hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => hovered = true),
      onExit: (_) => setState(() => hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeOut,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        transform: Matrix4.translationValues(0, hovered ? -2 : 0, 0),
        decoration: BoxDecoration(
          color: hovered
              ? AppTheme.accentBlue
              : AppTheme.accentBlue.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: hovered
                ? AppTheme.accentBlue
                : AppTheme.accentBlue.withValues(alpha: 0.25),
          ),
          boxShadow: hovered
              ? [
                  BoxShadow(
                    color: AppTheme.accentBlue.withValues(alpha: 0.25),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Text(
          widget.label,
          style: AppTheme.mono(context).copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: hovered ? Colors.white : AppTheme.accentBlue,
          ),
        ),
      ),
    );
  }
}

// =========================================================
// CONTACT
// =========================================================
class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppTheme.bgOffWhite,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 100),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: ScrollReveal(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Let's build something together.",
                  style: AppTheme.heading(context)
                      .copyWith(fontSize: 36, height: 1.2),
                ),
                const SizedBox(height: 20),
                Text(
                  "I'm open to full-time roles and freelance projects. "
                  "If you have an idea, a job, or just want to talk Flutter — reach out.",
                  style: AppTheme.body(context)
                      .copyWith(fontSize: 17, height: 1.7),
                ),
                const SizedBox(height: 40),

                _contactRow(
                  context,
                  icon: Icons.email_outlined,
                  label: 'Email',
                  value: LaunchHelpers.email,
                  onTap: () => LaunchHelpers.openEmail(),
                ),
                const SizedBox(height: 16),
                _contactRow(
                  context,
                  icon: Icons.code,
                  label: 'GitHub',
                  value: 'github.com/AbdulRaheem4340',
                  onTap: () => LaunchHelpers.openUrl(LaunchHelpers.github),
                ),
                const SizedBox(height: 16),
                _contactRow(
                  context,
                  icon: Icons.work_outline,
                  label: 'LinkedIn',
                  value: 'linkedin.com/in/abdul-raheem-7b0486370',
                  onTap: () => LaunchHelpers.openUrl(LaunchHelpers.linkedIn),
                ),

                const SizedBox(height: 40),
                _primaryButton(
                  context,
                  'SEND ME AN EMAIL →',
                  () => LaunchHelpers.openEmail(context: context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _contactRow(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppTheme.cardBorder),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppTheme.accentBlue, size: 22),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTheme.mono(context)
                        .copyWith(fontSize: 11, color: AppTheme.textGray),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: AppTheme.body(context).copyWith(
                      color: AppTheme.textDark,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(Icons.arrow_outward, size: 18, color: AppTheme.textGray),
          ],
        ),
      ),
    );
  }
}

// =========================================================
// FOOTER
// =========================================================
class RetroFooter extends StatelessWidget {
  const RetroFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppTheme.terminalBg,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 28),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1000),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '> system ready  |  projects: 6  |  stack: flutter + ai',
                style: AppTheme.mono(context)
                    .copyWith(color: AppTheme.terminalGreen, fontSize: 13),
              ),
              const SizedBox(height: 6),
              Text(
                '> built with flutter web  |  © 2026 abdul raheem',
                style: AppTheme.mono(context).copyWith(
                  color: AppTheme.terminalGreen.withValues(alpha: 0.7),
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Text(
                    '> status: ',
                    style: AppTheme.mono(context).copyWith(
                      color: AppTheme.terminalGreen.withValues(alpha: 0.7),
                      fontSize: 13,
                    ),
                  ),
                  Text(
                        '[AVAILABLE]',
                        style: AppTheme.mono(context).copyWith(
                          color: AppTheme.accentBlue,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                      .animate(onPlay: (c) => c.repeat(reverse: true))
                      .fade(begin: 0.35, end: 1.0, duration: 900.ms),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _primaryButton(BuildContext context, String text, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(8),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
      decoration: BoxDecoration(
        color: AppTheme.accentBlue,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: AppTheme.heading(context)
            .copyWith(color: Colors.white, fontSize: 15),
      ),
    ),
  );
}
