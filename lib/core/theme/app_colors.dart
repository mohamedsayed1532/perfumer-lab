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
      CupertinoDynamicColor.withBrightness(
    color: Color(0xFFF2F2F7), // Apple HIG grouped background (light)
    darkColor: Color(0xFF0D0E17), // Deep midnight to match LiquidGlassBackground
  );
  static const CupertinoDynamicColor secondarySystemGroupedBackground =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xFFFFFFFF), // Apple HIG secondary grouped (light)
    darkColor: Color(0xFF1A1C29), // Elevated midnight card surface
  );
  static const CupertinoDynamicColor tertiarySystemGroupedBackground =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xFFF2F2F7),
    darkColor: Color(0xFF222538), // Tertiary card surface
  );

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

  // Accent & Fragrance-domain colors — Radiant Champagne & Warm Amber Atelier Palette
  static const CupertinoDynamicColor accent =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xFF9E6510), // Warm amber-brass, light mode
    darkColor: Color(0xFFE5A93C), // Radiant champagne amber gold, dark mode
  );
  static const CupertinoDynamicColor amberRose = CupertinoDynamicColor.withBrightness(
    color: Color(0xFFC0392B),
    darkColor: Color(0xFFE57373),
  );
  static const CupertinoDynamicColor goldAccent = CupertinoDynamicColor.withBrightness(
    color: Color(0xFFD4AC0D),
    darkColor: Color(0xFFF3C668),
  );
  static const CupertinoDynamicColor naturalGreen = CupertinoDynamicColor.withBrightness(
    color: Color(0xFF27AE60),
    darkColor: Color(0xFF48BB78),
  );

  // Liquid Glass base colors
  static const CupertinoDynamicColor liquidGlassBg =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xD9FFFFFF), // 85% translucent white frosted glass
    darkColor: Color(0xD012131C), // Deep obsidian glass
  );

  static const CupertinoDynamicColor liquidGlassBorder =
      CupertinoDynamicColor.withBrightness(
    color: Color(0x4DFFFFFF), // 30% specular light highlight
    darkColor: Color(0x35E5A93C), // Specular warm champagne gold highlight
  );

  static const CupertinoDynamicColor cardBorder =
      CupertinoDynamicColor.withBrightness(
    color: Color(0x1A000000), // Subtle hairline card border (light)
    darkColor: Color(0x24FFFFFF), // Translucent specular hairline (dark)
  );

  /// High-contrast foreground color for text/icons rendered on [accent] surfaces.
  static Color onAccent(BuildContext context) {
    return CupertinoTheme.brightnessOf(context) == Brightness.dark
        ? const Color(0xFF14161E)
        : CupertinoColors.white;
  }
}
