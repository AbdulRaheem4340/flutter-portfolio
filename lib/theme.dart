import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // --- COLORS ---
  
  static const Color bgOffWhite = Color(0xFFF4F7F5); 
  static const Color bgAlt = Color(0xFFE3EAE5); 
  static const Color textDark = Color(0xFF1E2922); 
  static const Color textGray = Color(0xFF5F6F65); 
  static const Color accentBlue = Color(0xFF10B981); 
  static const Color accentHover = Color(0xFF059669);
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color cardBorder = Color(0xFFD1DDD5);

  static const Color terminalBg = Color(0xFF1A1A1A);
  static const Color terminalGreen = Color(0xFF22C55E);

  // --- TYPOGRAPHY ---
  static TextStyle heading(BuildContext context) {
    return GoogleFonts.spaceGrotesk(
      color: textDark,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle body(BuildContext context) {
    return GoogleFonts.inter(color: textGray, fontSize: 16, height: 1.6);
  }

  // Retro/Code: JetBrains Mono
  static TextStyle mono(BuildContext context) {
    return GoogleFonts.jetBrainsMono(color: textGray, fontSize: 14);
  }
}
