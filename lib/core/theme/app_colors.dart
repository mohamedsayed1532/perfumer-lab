import 'package:cupertino_ui/cupertino_ui.dart';

/// Semantic adaptive colors following Apple HIG guidelines.
/// Meets WCAG AA contrast (minimum 4.5:1, striving for 7:1 for text).
class AppColors {
  AppColors._();

  // Background hierarchy
  static const CupertinoDynamicColor systemBackground =
      CupertinoColors.systemBackground;
  static const CupertinoDynamicColor secondarySystemBackground =
      CupertinoColors.secondarySystemBackground;
  static const CupertinoDynamicColor tertiarySystemBackground =
      CupertinoColors.tertiarySystemBackground;

  static const CupertinoDynamicColor systemGroupedBackground =
      CupertinoColors.systemGroupedBackground;
  static const CupertinoDynamicColor secondarySystemGroupedBackground =
      CupertinoColors.secondarySystemGroupedBackground;
  static const CupertinoDynamicColor tertiarySystemGroupedBackground =
      CupertinoColors.tertiarySystemGroupedBackground;

  // Text / Label hierarchy
  static const CupertinoDynamicColor label = CupertinoColors.label;
  static const CupertinoDynamicColor secondaryLabel =
      CupertinoColors.secondaryLabel;
  static const CupertinoDynamicColor tertiaryLabel =
      CupertinoColors.tertiaryLabel;
  static const CupertinoDynamicColor quaternaryLabel =
      CupertinoColors.quaternaryLabel;

  // Separator & Borders
  static const CupertinoDynamicColor separator = CupertinoColors.separator;
  static const CupertinoDynamicColor opaqueSeparator =
      CupertinoColors.opaqueSeparator;

  // Accent & Fragrance-domain colors
  static const CupertinoDynamicColor accent =
      CupertinoColors.systemIndigo; // Refined perfumery tone
  static const CupertinoDynamicColor amberRose = CupertinoDynamicColor.withBrightness(
    color: Color(0xFFC0392B),
    darkColor: Color(0xFFE74C3C),
  );
  static const CupertinoDynamicColor goldAccent = CupertinoDynamicColor.withBrightness(
    color: Color(0xFFD4AC0D),
    darkColor: Color(0xFFF1C40F),
  );
  static const CupertinoDynamicColor naturalGreen = CupertinoDynamicColor.withBrightness(
    color: Color(0xFF27AE60),
    darkColor: Color(0xFF2ECC71),
  );

  // Liquid Glass base colors
  static const CupertinoDynamicColor liquidGlassBg =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xCCF2F2F7), // 80% opacity light glass
    darkColor: Color(0xB31C1C1E), // 70% opacity dark glass
  );

  static const CupertinoDynamicColor liquidGlassBorder =
      CupertinoDynamicColor.withBrightness(
    color: Color(0x33FFFFFF), // Specular light highlight
    darkColor: Color(0x26FFFFFF), // Subtle specular dark highlight
  );
}
