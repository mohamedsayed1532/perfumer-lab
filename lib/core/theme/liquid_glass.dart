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
        ? const Color(0x38FFFFFF) // 22% specular top edge
        : const Color(0x60FFFFFF);

    final effectiveBorderColor = borderColor ?? topBorderColor;

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ??
            (isDark
                ? const Color(0xCC1A1C29) // Rich solid translucent midnight slab
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
                    BoxShadow(
                      color: const Color(0x30000000),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                      spreadRadius: -2,
                    ),
                  ]
                : [
                    BoxShadow(
                      color: const Color(0x12000000),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
                    ),
                  ]),
        gradient: isDark
            ? const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xD9222538),
                  Color(0xB3151724),
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
        color: Color(0xFF08090D), // Deep obsidian lab base
        gradient: RadialGradient(
          center: Alignment(-0.6, -0.7),
          radius: 1.4,
          colors: [
            Color(0xFF16152B), // Ambient ethereal violet-indigo glow
            Color(0xFF0D0E17), // Deep midnight mid-tone
            Color(0xFF06070A), // Rich obsidian boundary
          ],
          stops: [0.0, 0.55, 1.0],
        ),
      ),
      child: child,
    );
  }
}
