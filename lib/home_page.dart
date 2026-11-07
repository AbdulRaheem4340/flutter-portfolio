import 'package:flutter/material.dart';
import 'package:flutter_portfolio/clippers.dart';
import 'package:flutter_portfolio/grain_painter.dart';
import 'package:flutter_portfolio/project_section.dart';
import 'package:flutter_portfolio/scanline_painter.dart';
import 'package:flutter_portfolio/typewitter_text.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'theme.dart';
import 'sections.dart';

// --- GETX CONTROLLER ---
class PortfolioController extends GetxController {
  var isScrolled = false.obs;
  late ScrollController scrollController;

  // Key to control the mobile drawer programmatically
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  // Keys for scroll-to-section
  final aboutKey = GlobalKey();
  final projectsKey = GlobalKey();
  final contactKey = GlobalKey();

  @override
  void onInit() {
    super.onInit();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset > 50 && !isScrolled.value) {
        isScrolled.value = true;
      } else if (scrollController.offset <= 50 && isScrolled.value) {
        isScrolled.value = false;
      }
    });
  }

  void scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx != null) {
      Scrollable.ensureVisible(
        ctx,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }
}

// --- MAIN PAGE ---
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PortfolioController());

    return Scaffold(
      key: controller.scaffoldKey, // Assign key to Scaffold for drawer control
      endDrawer: _buildMobileDrawer(
        context,
        controller,
      ), // Responsive Retro Drawer
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: controller.scrollController,
            child: Column(
              children: [
                const HeroSection(),

                // ABOUT
                KeyedSubtree(
                  key: controller.aboutKey,
                  child: const AboutSection(),
                ),

                // TECH STACK
                const TechStackSection(),

                // PROJECTS
                KeyedSubtree(
                  key: controller.projectsKey,
                  child: const ProjectsSection(),
                ),

                // CONTACT
                KeyedSubtree(
                  key: controller.contactKey,
                  child: const ContactSection(),
                ),

                // RETRO FOOTER
                const RetroFooter(),
              ],
            ),
          ),

          // STICKY NAV
          Obx(
            () => Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: _buildNavBar(context, controller),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavBar(BuildContext context, PortfolioController controller) {
    final isScrolled = controller.isScrolled.value;
    final isMobile = MediaQuery.of(context).size.width < 700;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: 80,
      decoration: BoxDecoration(
        color: isScrolled
            ? AppTheme.bgOffWhite.withValues(alpha: 0.96)
            : Colors.transparent,
        border: Border(
          bottom: BorderSide(
            color: isScrolled ? AppTheme.cardBorder : Colors.transparent,
            width: 1,
          ),
        ),
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // LOGO
                GestureDetector(
                  onTap: () {
                    controller.scrollController.animateTo(
                      0,
                      duration: const Duration(milliseconds: 500),
                      curve: Curves.easeOut,
                    );
                  },
                  child: Row(
                    children: [
                      Text(
                        'Abdul Raheem',
                        style: AppTheme.heading(context)
                            .copyWith(fontSize: 24, letterSpacing: -0.5),
                      ),
                      Text(
                        '.dev',
                        style: AppTheme.heading(context).copyWith(
                          fontSize: 24,
                          color: AppTheme.accentBlue,
                          letterSpacing: -0.5,
                        ),
                      ),
                    ],
                  ),
                ),

                if (!isMobile)
                  Row(
                    children: [
                      _navLink(
                        context,
                        'About',
                        () => controller.scrollTo(controller.aboutKey),
                      ),
                      const SizedBox(width: 28),
                      _navLink(
                        context,
                        'Projects',
                        () => controller.scrollTo(controller.projectsKey),
                      ),
                      const SizedBox(width: 28),
                      _navLink(
                        context,
                        'Contact',
                        () => controller.scrollTo(controller.contactKey),
                      ),
                      const SizedBox(width: 28),
                    ],
                  )
                else
                  // Mobile Drawer Trigger Button
                  IconButton(
                    onPressed: () {
                      controller.scaffoldKey.currentState?.openEndDrawer();
                    },
                    icon: const Icon(
                      Icons.menu,
                      color: AppTheme.textDark,
                      size: 28,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navLink(BuildContext context, String title, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Text(
        title,
        style: AppTheme.mono(context)
            .copyWith(color: AppTheme.textDark, fontWeight: FontWeight.w600),
      ),
    );
  }

  // --- RETRO DRAWER FOR MOBILE DEVICES ---
  Widget _buildMobileDrawer(
    BuildContext context,
    PortfolioController controller,
  ) {
    return Drawer(
      backgroundColor: AppTheme.bgOffWhite,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          bottomLeft: Radius.circular(16),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Drawer Header / Brand
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Raheem',
                        style: AppTheme.heading(context).copyWith(fontSize: 22),
                      ),
                      Text(
                        '.dev',
                        style: AppTheme.heading(context)
                            .copyWith(fontSize: 22, color: AppTheme.accentBlue),
                      ),
                    ],
                  ),
                  IconButton(
                    onPressed: () => Get.back(),
                    icon: const Icon(Icons.close, color: AppTheme.textDark),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Container(height: 1, color: AppTheme.cardBorder),
              const SizedBox(height: 48),

              // Drawer Navigation Items (Staggered Animation)
              _buildDrawerItem(
                context,
                index: 1,
                label: 'About',
                onTap: () {
                  Get.back(); // Closes the drawer
                  controller.scrollTo(controller.aboutKey);
                },
              ),
              const SizedBox(height: 24),
              _buildDrawerItem(
                context,
                index: 2,
                label: 'Projects',
                onTap: () {
                  Get.back();
                  controller.scrollTo(controller.projectsKey);
                },
              ),
              const SizedBox(height: 24),
              _buildDrawerItem(
                context,
                index: 3,
                label: 'Contact',
                onTap: () {
                  Get.back();
                  controller.scrollTo(controller.contactKey);
                },
              ),

              const Spacer(),

              // Mobile terminal footer line
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '> system_mode: responsive_web',
                    style: AppTheme.mono(context)
                        .copyWith(fontSize: 11, color: AppTheme.textGray),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '> status: ',
                        style: AppTheme.mono(context)
                            .copyWith(fontSize: 11, color: AppTheme.textGray),
                      ),
                      Text(
                            '[OPEN_FOR_WORK]',
                            style: AppTheme.mono(context).copyWith(
                              fontSize: 11,
                              color: AppTheme.accentBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                          .animate(onPlay: (c) => c.repeat(reverse: true))
                          .fade(begin: 0.4, end: 1.0, duration: 800.ms),
                    ],
                  ),
                ],
              ).animate().fadeIn(delay: 500.ms),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required int index,
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            child: Row(
              children: [
                const SizedBox(width: 4),
                Text(
                  label,
                  style: AppTheme.heading(context).copyWith(
                    fontSize: 20,
                    color: AppTheme.textDark,
                    letterSpacing: -0.5,
                  ),
                ),
              ],
            ),
          ),
        )
        .animate()
        .fadeIn(delay: (index * 80).ms, duration: 350.ms)
        .slideX(begin: 0.1, end: 0, curve: Curves.easeOut);
  }
}

// --- HERO SECTION ---
class HeroSection extends StatelessWidget {
  const HeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final nameSize = width > 800 ? 64.0 : 42.0;

    return ClipPath(
      clipper: GlitchTearClipper(),
      child: ScanlineOverlay(
        opacity: 0.02,
        child: GrainOverlay(
          opacity: 0.035,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: width > 800 ? 150 : 120,
              bottom: 130,
              left: 24,
              right: 24,
            ),
            decoration: const BoxDecoration(color: AppTheme.bgAlt),
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 1000),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Decrypts text to actual name first
                    TypewriterText(
                      text: 'Abdul Raheem',
                      style: AppTheme.heading(context).copyWith(
                        fontSize: nameSize,
                        height: 1.05,
                        letterSpacing: -1.8,
                      ),
                    ),

                    const SizedBox(height: 16),

                    // animated accent bar under name
                    Container(
                          height: 3,
                          width: 72,
                          decoration: BoxDecoration(
                            color: AppTheme.accentBlue,
                            borderRadius: BorderRadius.circular(2),
                          ),
                        )
                        .animate(delay: 1700.ms)
                        .fadeIn(duration: 400.ms)
                        .scaleX(
                          begin: 0,
                          end: 1,
                          alignment: Alignment.centerLeft,
                          curve: Curves.easeOutCubic,
                        ),

                    const SizedBox(height: 20),

                    Text(
                          'A passionate Flutter Fresher building complex apps with AI, Maps, and Custom UI.\nAlways learning. Always building.',
                          style: AppTheme.body(context).copyWith(
                            fontSize: width > 800 ? 19 : 16,
                            height: 1.55,
                            color: AppTheme.textGray,
                          ),
                        )
                        .animate(delay: 1900.ms)
                        .fadeIn(duration: 650.ms)
                        .slideY(begin: 0.15, end: 0),

                    const SizedBox(height: 36),

                    Wrap(
                      spacing: 14,
                      runSpacing: 12,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        ElevatedButton(
                              onPressed: () {
                                final c = Get.find<PortfolioController>();
                                c.scrollTo(c.projectsKey);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: AppTheme.accentBlue,
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 28,
                                  vertical: 18,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 0,
                              ),
                              child: Text(
                                'VIEW MY WORK',
                                style: AppTheme.heading(
                                  context,
                                ).copyWith(color: Colors.white, fontSize: 15),
                              ),
                            )
                            .animate(delay: 2100.ms)
                            .fadeIn(duration: 500.ms)
                            .slideY(begin: 0.2, end: 0),

                        Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 7,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.accentBlue.withValues(
                                  alpha: 0.1,
                                ),
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: AppTheme.accentBlue.withValues(
                                    alpha: 0.25,
                                  ),
                                ),
                              ),
                              child: Text(
                                '[AVAILABLE FOR WORK]',
                                style: AppTheme.mono(context).copyWith(
                                  color: AppTheme.accentBlue,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            )
                            .animate(delay: 2300.ms)
                            .fadeIn(duration: 500.ms)
                            .then()
                            .animate(onPlay: (c) => c.repeat(reverse: true))
                            .fade(begin: 0.45, end: 1, duration: 900.ms),
                      ],
                    ),

                    const SizedBox(height: 48),

                    // terminal lines staggered
                    Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _terminalLine(
                              context,
                              '> status: constantly learning new things',
                            ),
                            const SizedBox(height: 6),
                            _terminalLine(
                              context,
                              '> stack: flutter | dart | firebase | custom_painter | getx',
                            ),
                            const SizedBox(height: 6),
                            _terminalLine(context, '> mode: open_to_work'),
                          ],
                        )
                        .animate(delay: 2500.ms)
                        .fadeIn(duration: 600.ms)
                        .slideY(begin: 0.12, end: 0),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _terminalLine(BuildContext context, String text) {
    return Text(
      text,
      style: AppTheme.mono(context)
          .copyWith(fontSize: 13, color: AppTheme.textGray),
    );
  }
}
