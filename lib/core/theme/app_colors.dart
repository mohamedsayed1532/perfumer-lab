import 'package:cupertino_ui/cupertino_ui.dart';

/// Semantic adaptive colors following the Stitch Analytical Lab palette & Apple HIG contrast rules.
class AppColors {
  AppColors._();

  // Background hierarchy
  static const CupertinoDynamicColor systemBackground =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xFFF2F5F8),
    darkColor: Color(0xFF0F141A), // Stitch surface_dim
  );
  static const CupertinoDynamicColor secondarySystemBackground =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xFFFFFFFF),
    darkColor: Color(0xFF181C23), // Stitch surface_container_low
  );
  static const CupertinoDynamicColor tertiarySystemBackground =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xFFE9EFF5),
    darkColor: Color(0xFF1C2027), // Stitch surface_container
  );

  static const CupertinoDynamicColor systemGroupedBackground =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xFFF2F5F8),
    darkColor: Color(0xFF0F141A),
  );
  static const CupertinoDynamicColor secondarySystemGroupedBackground =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xFFFFFFFF),
    darkColor: Color(0xFF1C2027), // Stitch surface_container
  );
  static const CupertinoDynamicColor tertiarySystemGroupedBackground =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xFFE9EFF5),
    darkColor: Color(0xFF262A32), // Stitch surface_container_high
  );

  /// Recessed dark well for numeric scale readouts and telemetry tiles.
  static const CupertinoDynamicColor recessedWell =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xFFE5ECF2),
    darkColor: Color(0xFF0A0E15), // Stitch surface_container_lowest
  );

  // Text / Label hierarchy
  static const CupertinoDynamicColor label =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xFF0F141A),
    darkColor: Color(0xFFDFE2EC), // Stitch on_surface
  );
  static const CupertinoDynamicColor secondaryLabel =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xFF475569),
    darkColor: Color(0xFFBDC8D1), // Stitch on_surface_variant
  );
  static const CupertinoDynamicColor tertiaryLabel =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xFF64748B),
    darkColor: Color(0xFF87929A), // Stitch outline
  );
  static const CupertinoDynamicColor quaternaryLabel =
      CupertinoColors.quaternaryLabel;

  // Separator & Borders
  static const CupertinoDynamicColor separator =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xFFD0D8E0),
    darkColor: Color(0xFF3E484F), // Stitch outline_variant
  );
  static const CupertinoDynamicColor opaqueSeparator =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xFFC2CCD6),
    darkColor: Color(0xFF3E484F),
  );

  // Stitch Analytical Lab Accents
  static const CupertinoDynamicColor accent =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xFF0284C7), // Crisp cyan-blue (light)
    darkColor: Color(0xFF38BDF8), // Stitch primary_container / customColor
  );

  /// High-readability cyan ink for inline telemetry & numeric accents on dark surfaces.
  static const CupertinoDynamicColor accentInk =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xFF0369A1),
    darkColor: Color(0xFF8ED5FF), // Stitch primary
  );

  static const CupertinoDynamicColor amberRose =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xFFDC2626),
    darkColor: Color(0xFFFFB4AB), // Stitch error
  );

  static const CupertinoDynamicColor goldAccent =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xFF0284C7),
    darkColor: Color(0xFF7BD0FF), // Stitch primary_fixed_dim
  );

  static const CupertinoDynamicColor naturalGreen =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xFF059669),
    darkColor: Color(0xFF56E5A9), // Stitch tertiary emerald
  );

  // Translucent chrome & card borders
  static const CupertinoDynamicColor liquidGlassBg =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xE6FFFFFF),
    darkColor: Color(0xE60F141A),
  );

  static const CupertinoDynamicColor liquidGlassBorder =
      CupertinoDynamicColor.withBrightness(
    color: Color(0x330F141A),
    darkColor: Color(0xFF3E484F),
  );

  static const CupertinoDynamicColor cardBorder =
      CupertinoDynamicColor.withBrightness(
    color: Color(0xFFDCE3EA),
    darkColor: Color(0xFF3E484F),
  );

  /// High-contrast foreground color for text/icons rendered on [accent] surfaces.
  static Color onAccent(BuildContext context) {
    return CupertinoTheme.brightnessOf(context) == Brightness.dark
        ? const Color(0xFF001E2C) // Stitch on_primary_fixed
        : CupertinoColors.white;
  }
}
