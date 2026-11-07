import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_portfolio/scroll_reveal.dart';
import 'package:url_launcher/url_launcher.dart';

import 'theme.dart';

// --- DATA MODEL ---
class ProjectModel {
  final String id;
  final String title;
  final String description;
  final List<String> techStack;
  final String imagePath;
  final String codeUrl;

  ProjectModel({
    required this.id,
    required this.title,
    required this.description,
    required this.techStack,
    required this.imagePath,
    required this.codeUrl,
  });
}

// --- MAIN PROJECTS SECTION ---
class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final projects = [
      ProjectModel(
        id: '01',
        title: 'AI Interview Coach',
        description: 'Practice interviews with an AI that listens to your voice, transcribes your answers in real-time, and gives detailed performance feedback.',
        techStack: ['GEMINI', 'VOICE', 'RIVERPOD', 'HIVE', 'MVVM'],
        imagePath: 'assets/project2.jpeg',
        codeUrl: 'https://github.com/AbdulRaheem4340/AI-Interview-Coach',
      ),
      ProjectModel(
        id: '02',
        title: 'OneThing - Deep Focus',
        description: 'One task. Full focus. No excuses. Solo focus sessions + real-time multiplayer Focus Rooms with Firestore sync and custom painter UI.',
        techStack: ['FIREBASE', 'GETX', 'CUSTOM PAINTER', 'REAL-TIME'],
        imagePath: 'assets/project3.jpeg',
        codeUrl: 'https://github.com/AbdulRaheem4340/OneThing',
      ),
      ProjectModel(
        id: '03',
        title: 'Hostel Finder',
        description: 'Dual-role platform: students search hostels on a live map, owners manage listings from a custom dashboard. Built with OpenStreetMap.',
        techStack: ['OPENSTREETMAP', 'FIREBASE', 'GETX', 'GEO-SEARCH'],
        imagePath: 'assets/project1.jpeg',
        codeUrl: 'https://github.com/AbdulRaheem4340/hoster-finder', // upload with this name
      ),
      ProjectModel(
        id: '04',
        title: 'AI Finance Coach',
        description: 'Track expenses, set budgets, and get AI-powered financial guidance. Beautiful analytics dashboards stored entirely locally.',
        techStack: ['RIVERPOD', 'HIVE', 'OPENROUTER', 'FL CHART'],
        imagePath: 'assets/project4.png',
        codeUrl: 'https://github.com/AbdulRaheem4340/finance-coach-flutter',
      ),
      ProjectModel(
        id: '05',
        title: 'Quiz Master',
        description: 'Full-stack quiz platform featuring Firebase Auth, multiple categories, and live global leaderboards.',
        techStack: ['FIREBASE AUTH', 'FIRESTORE', 'GETX'],
        imagePath: 'assets/project5.png',
        codeUrl: 'https://github.com/AbdulRaheem4340/quiz-master',
      ),
      ProjectModel(
        id: '06',
        title: 'AI Chat Assistant',
        description: 'Real-time AI chat application with persistent local history, smart responses, and a clean, responsive messaging UI.',
        techStack: ['AI API', 'LOCAL STORAGE', 'CLEAN UI'],
        imagePath: 'assets/project6.jpeg',
        codeUrl: 'https://github.com/AbdulRaheem4340/chat_app',
      ),
    ];

    return Container(
      width: double.infinity,
      color: AppTheme.bgOffWhite,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 100),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                    'Built with Flutter.\nShipped with care.',
                    style: AppTheme.heading(context)
                        .copyWith(fontSize: 40, height: 1.1, letterSpacing: -1),
                  )
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: 0.2, end: 0, curve: Curves.easeOut),
              const SizedBox(height: 60),

              ...projects.asMap().entries.map((entry) {
                final index = entry.key;
                final project = entry.value;
                final isImageLeft = index % 2 == 0;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 56),
                  child: ScrollReveal(
                    duration: const Duration(milliseconds: 850),
                    child:
                        ProjectCard(project: project, isImageLeft: isImageLeft)
                            .animate(delay: (90 * index).ms)
                            .fadeIn(duration: 650.ms)
                            .slideY(
                              begin: 0.14,
                              end: 0,
                              curve: Curves.easeOutCubic,
                            ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

// --- INTERACTIVE PROJECT CARD ---
class ProjectCard extends StatefulWidget {
  final ProjectModel project;
  final bool isImageLeft;

  const ProjectCard({
    super.key,
    required this.project,
    required this.isImageLeft,
  });

  @override
  State<ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<ProjectCard> {
  bool isHovered = false;

  Future<void> _launch(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width > 800;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 280),
        curve: Curves.easeOut,
        transform: Matrix4.translationValues(0, isHovered ? -10 : 0, 0),
        decoration: BoxDecoration(
          color: AppTheme.cardBg,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isHovered
                ? AppTheme.accentBlue.withValues(alpha: 0.35)
                : AppTheme.cardBorder,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isHovered ? 0.12 : 0.04),
              blurRadius: isHovered ? 28 : 12,
              offset: Offset(0, isHovered ? 16 : 8),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: isDesktop
            ? _buildDesktopLayout(context)
            : _buildMobileLayout(context),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context) {
    final children = [
      Expanded(
        flex: 5,
        child: Container(
          color: AppTheme.bgAlt,
          padding: const EdgeInsets.all(28),
          child: Center(child: _buildPhoneFrame()),
        ),
      ),
      Expanded(flex: 6, child: _buildContent(context)),
    ];

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: widget.isImageLeft ? children : children.reversed.toList(),
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          color: AppTheme.bgAlt,
          padding: const EdgeInsets.fromLTRB(24, 28, 24, 12),
          child: Center(child: _buildPhoneFrame()),
        ),
        _buildContent(context),
      ],
    );
  }

  Widget _buildPhoneFrame() {
    return AnimatedScale(
      scale: isHovered ? 1.04 : 1.0,
      duration: const Duration(milliseconds: 280),
      curve: Curves.easeOut,
      child: Container(
        constraints: const BoxConstraints(maxWidth: 250, maxHeight: 500),
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(color: const Color(0xFF222222), width: 8),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.20),
              blurRadius: 24,
              offset: const Offset(0, 14),
            ),
          ],
        ),
        clipBehavior: Clip.antiAlias,
        child: AspectRatio(
          aspectRatio: 9 / 19.5,
          child: Image.asset(
            widget.project.imagePath,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: AppTheme.bgAlt,
                alignment: Alignment.center,
                padding: const EdgeInsets.all(16),
                child: Text(
                  'Add Image:\n${widget.project.imagePath}',
                  textAlign: TextAlign.center,
                  style: AppTheme.mono(context).copyWith(fontSize: 12),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.project.title,
            style: AppTheme.heading(context).copyWith(fontSize: 28),
          ),
          const SizedBox(height: 12),
          Text(
            widget.project.description,
            style: AppTheme.body(context).copyWith(fontSize: 15, height: 1.6),
          ),
          const SizedBox(height: 20),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: widget.project.techStack
                .map((tech) => _buildTechBadge(context, tech))
                .toList(),
          ),
          const SizedBox(height: 32),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              _buildButton(
                context,
                label: 'VIEW CODE ↗',
                isPrimary: false,
                onTap: () => _launch(widget.project.codeUrl),
              ),
              _buildButton(
                context,
                label: 'REQUEST DEMO ↗',
                isPrimary: true,
                onTap: () => _launch(
                  'mailto:ar4942876@gmail.com'
                  '?subject=Demo%20Request%20-%20${Uri.encodeComponent(widget.project.title)}'
                  '&body=Hi%20Abdul%2C%0A%0AI%27d%20like%20to%20see%20a%20demo%20of%20${Uri.encodeComponent(widget.project.title)}.%0A%0AThanks!',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTechBadge(BuildContext context, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: AppTheme.accentBlue.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: AppTheme.accentBlue.withValues(alpha: 0.3)),
      ),
      child: Text(
        text,
        style: AppTheme.mono(context).copyWith(
          fontSize: 11,
          color: AppTheme.accentBlue,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildButton(
    BuildContext context, {
    required String label,
    required bool isPrimary,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isPrimary ? AppTheme.accentBlue : Colors.transparent,
          border: Border.all(color: AppTheme.accentBlue),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          label,
          style: AppTheme.mono(context).copyWith(
            color: isPrimary ? Colors.white : AppTheme.accentBlue,
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ),
    );
  }
}
