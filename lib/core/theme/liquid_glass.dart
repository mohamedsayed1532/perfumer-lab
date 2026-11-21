import 'package:cupertino_ui/cupertino_ui.dart';
import 'app_colors.dart';

/// Apple HIG Liquid Glass component.
///
/// Uses high-efficiency GPU-accelerated container rendering without stacking
/// BackdropFilter on every list row to prevent scroll frame drops on mobile hardware.
class LiquidGlass extends StatelessWidget {
  final Widget child;
  final double blurSigma;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? borderColor;
  final bool hasSpecularBorder;
  final double borderWidth;
  final List<BoxShadow>? customShadow;

  const LiquidGlass({
    super.key,
    required this.child,
    this.blurSigma = 24.0,
    this.borderRadius,
    this.padding,
    this.backgroundColor,
    this.borderColor,
    this.hasSpecularBorder = true,
    this.borderWidth = 0.75,
    this.customShadow,
  });

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? BorderRadius.circular(18);
    final isDark = CupertinoTheme.brightnessOf(context) == Brightness.dark;

    final topBorderColor = isDark
        ? const Color(0x35E5A93C) // Specular warm champagne gold rim highlight
        : const Color(0x60FFFFFF);

    final effectiveBorderColor = borderColor ?? topBorderColor;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ??
            (isDark
                ? const Color(0xEB13141D) // Rich solid translucent obsidian slab
                : const Color(0xF2FFFFFF)),
        borderRadius: radius,
        border: hasSpecularBorder
            ? Border.all(
                color: effectiveBorderColor,
                width: borderWidth,
              )
            : null,
        boxShadow: customShadow ??
            (isDark
                ? [
                    const BoxShadow(
                      color: Color(0x50000000),
                      blurRadius: 20,
                      offset: Offset(0, 8),
                      spreadRadius: -2,
                    ),
                    const BoxShadow(
                      color: Color(0x0DE5A93C),
                      blurRadius: 16,
                      offset: Offset(0, 1),
                    ),
                  ]
                : [
                    const BoxShadow(
                      color: Color(0x12000000),
                      blurRadius: 14,
                      offset: Offset(0, 4),
                    ),
                  ]),
        gradient: isDark
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xF0181A25), // Radiant upper obsidian glass
                  Color(0xE00E0F17), // Deep atelier velvet glass
                ],
              )
            : null,
      ),
      child: child,
    );
  }
}

/// Ambient background canvas for Liquid Glass.
class LiquidGlassBackground extends StatelessWidget {
  final Widget child;
  const LiquidGlassBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = CupertinoTheme.brightnessOf(context) == Brightness.dark;

    if (!isDark) {
      return Container(
        color: AppColors.systemGroupedBackground.resolveFrom(context),
        child: child,
      );
    }

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF07080C), // Pure obsidian atelier base
        gradient: RadialGradient(
          center: Alignment(-0.5, -0.6),
          radius: 1.4,
          colors: [
            Color(0xFF1D1711), // Ethereal warm amber-resin atmospheric glow
            Color(0xFF0C0D13), // Deep atelier mid-tone
            Color(0xFF060709), // Obsidian boundary
          ],
          stops: [0.0, 0.55, 1.0],
        ),
      ),
      child: child,
    );
  }
}
