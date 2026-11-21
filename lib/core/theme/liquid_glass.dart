import 'dart:ui';
import 'package:cupertino_ui/cupertino_ui.dart';
import 'app_colors.dart';

/// Apple HIG Liquid Glass component.
///
/// Implements Apple's dynamic translucent material combining optical Gaussian
/// blur, specular gradient borders, subtle surface gloss, and adaptive luminosity.
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

    // Luminous glass tint with subtle specular gradient
    final glassColor = backgroundColor ??
        (isDark
            ? const Color(0x1CFFFFFF) // 11% white glass over dark
            : const Color(0xC0FFFFFF)); // 75% white glass over light

    final topBorderColor = isDark
        ? const Color(0x45FFFFFF) // 27% bright specular top edge
        : const Color(0x80FFFFFF); // Light specular top edge

    final effectiveBorderColor = borderColor ?? topBorderColor;

    return Container(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: customShadow ??
            (isDark
                ? [
                    BoxShadow(
                      color: const Color(0x40000000),
                      blurRadius: 24,
                      offset: const Offset(0, 10),
                      spreadRadius: -2,
                    ),
                    BoxShadow(
                      color: AppColors.accent
                          .resolveFrom(context)
                          .withValues(alpha: 0.04),
                      blurRadius: 30,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: const Color(0x1A000000),
                      blurRadius: 18,
                      offset: const Offset(0, 8),
                    ),
                  ]),
      ),
      child: ClipRRect(
        borderRadius: radius,
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: blurSigma,
            sigmaY: blurSigma,
          ),
          child: Container(
            padding: padding,
            decoration: BoxDecoration(
              color: glassColor,
              borderRadius: radius,
              border: hasSpecularBorder
                  ? Border.all(
                      color: effectiveBorderColor,
                      width: borderWidth,
                    )
                  : null,
              gradient: isDark
                  ? LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0x24FFFFFF),
                        const Color(0x08FFFFFF),
                      ],
                      stops: const [0.0, 1.0],
                    )
                  : LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xE6FFFFFF),
                        const Color(0xB3FFFFFF),
                      ],
                    ),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// Ambient background canvas for Liquid Glass.
///
/// Under pure #000000 OLED black, glass blur and refraction are optically invisible.
/// This scaffold provides the deep atmospheric dark-lab mesh gradient with subtle
/// essence glows (indigo and warm amber highlights) so that Liquid Glass controls
/// and cards refract and blur with visible optical depth.
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
