import 'package:flutter/material.dart';

class AppTheme {
  // Brand Colors matching Raintech Hotel Management screenshots
  static const Color background = Color(0xFFF5EFE6); // Warm beige background
  static const Color cardBg = Color(0xFFFFFFFF);
  static const Color cardBorder = Color(0xFFE6DFD5);
  
  static const Color primaryNavy = Color(0xFF132B45); // Deep navy for headers & primary buttons
  static const Color primaryNavyHover = Color(0xFF0D1E32);
  static const Color secondaryNavy = Color(0xFF1E3A5F);
  
  static const Color textDark = Color(0xFF1E293B);
  static const Color textMuted = Color(0xFF64748B);
  static const Color textLight = Color(0xFF94A3B8);

  // Status & Badge Colors
  static const Color availableGreen = Color(0xFFE8F5E9);
  static const Color availableGreenText = Color(0xFF2E7D32);
  static const Color availableGreenBorder = Color(0xFFA5D6A7);

  static const Color occupiedRed = Color(0xFFFFEBEE);
  static const Color occupiedRedText = Color(0xFFC62828);
  static const Color occupiedRedBorder = Color(0xFFEF9A9A);

  static const Color warningAmber = Color(0xFFFFF3E0);
  static const Color warningAmberText = Color(0xFFD97706);
  static const Color warningAmberBorder = Color(0xFFFFCC80);

  static const Color infoBlue = Color(0xFFE3F2FD);
  static const Color infoBlueText = Color(0xFF1565C0);
  static const Color infoBlueBorder = Color(0xFF90CAF9);

  // Room Type Tag Colors
  static const Color deluxeTagBg = Color(0xFFF3E8FF);
  static const Color deluxeTagText = Color(0xFF6B21A8);

  static const Color suiteTagBg = Color(0xFFFEF3C7);
  static const Color suiteTagText = Color(0xFF92400E);

  static const Color familyTagBg = Color(0xFFCCFBF1);
  static const Color familyTagText = Color(0xFF0F766E);

  static const Color standardTagBg = Color(0xFFF1F5F9);
  static const Color standardTagText = Color(0xFF334155);

  // Box Shadow
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: const Color(0xFF000000).withValues(alpha: 0.04),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get elevatedShadow => [
        BoxShadow(
          color: const Color(0xFF000000).withValues(alpha: 0.08),
          blurRadius: 16,
          offset: const Offset(0, 6),
        ),
      ];

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      colorScheme: ColorScheme.light(
        primary: primaryNavy,
        secondary: secondaryNavy,
        surface: cardBg,
        error: occupiedRedText,
      ),
      fontFamily: 'Roboto',
      cardTheme: CardThemeData(
        color: cardBg,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: cardBorder, width: 1),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryNavy,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.3,
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primaryNavy,
          side: const BorderSide(color: cardBorder, width: 1.2),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          textStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      dividerTheme: const DividerThemeData(
        color: cardBorder,
        thickness: 1,
        space: 24,
      ),
    );
  }
}
