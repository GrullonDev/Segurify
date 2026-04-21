import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DesignSystem {
  // Colors
  static const Color background = Color(0xFF070B12);
  static const Color surface = Color(0xFF0F172A);
  static const Color cardBg = Color(0xFF1E293B);
  static const Color accent = Color(0xFFFF6820);
  static const Color accentGradientStart = Color(0xFFFF6820);
  static const Color accentGradientEnd = Color(0xFFE55710);
  
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  // Spacing
  static const double spacingXs = 4.0;
  static const double spacingSm = 8.0;
  static const double spacingMd = 16.0;
  static const double spacingLg = 24.0;
  static const double spacingXl = 32.0;
  static const double spacing2Xl = 48.0;
  static const double spacing3Xl = 64.0;

  // Text Styles
  static TextStyle h1 = GoogleFonts.outfit(
    fontSize: 56,
    fontWeight: FontWeight.bold,
    color: textPrimary,
    height: 1.1,
    letterSpacing: -0.5,
  );

  static TextStyle h2 = GoogleFonts.outfit(
    fontSize: 40,
    fontWeight: FontWeight.bold,
    color: textPrimary,
    height: 1.2,
  );

  static TextStyle h3 = GoogleFonts.outfit(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: textPrimary,
  );

  static TextStyle bodyLarge = GoogleFonts.inter(
    fontSize: 18,
    color: textSecondary,
    height: 1.5,
  );

  static TextStyle bodyMedium = GoogleFonts.inter(
    fontSize: 16,
    color: textSecondary,
    height: 1.5,
  );

  static TextStyle bodySmall = GoogleFonts.inter(
    fontSize: 14,
    color: textMuted,
  );

  static TextStyle label = GoogleFonts.outfit(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: accent,
    letterSpacing: 1.5,
  );

  // Decorations
  static BoxDecoration glassDecoration = BoxDecoration(
    color: Colors.white.withOpacity(0.05),
    borderRadius: BorderRadius.circular(16),
    border: Border.all(color: Colors.white.withOpacity(0.1)),
  );

  static BoxDecoration cardDecoration = BoxDecoration(
    color: cardBg,
    borderRadius: BorderRadius.circular(20),
    border: Border.all(color: Colors.white.withOpacity(0.05)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.2),
        blurRadius: 20,
        offset: const Offset(0, 10),
      ),
    ],
  );

  static LinearGradient primaryGradient = const LinearGradient(
    colors: [accentGradientStart, accentGradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
