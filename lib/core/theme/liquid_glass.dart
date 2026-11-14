import 'dart:ui';
import 'package:cupertino_ui/cupertino_ui.dart';
import 'app_colors.dart';

/// Apple HIG Liquid Glass component.
///
/// Provides a translucent frosted-glass visual effect with a Gaussian blur,
/// specular gradient border, and adaptive surface tinting.
/// Designed for floating navigation bars, toolbars, and bench HUD cards.
class LiquidGlass extends StatelessWidget {
  final Widget child;
  final double blurSigma;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final Color? borderColor;
  final double borderWidth;
  final bool hasSpecularBorder;

  const LiquidGlass({
    super.key,
    required this.child,
    this.blurSigma = 20.0,
    this.borderRadius,
    this.padding,
    this.backgroundColor,
    this.borderColor,
    this.borderWidth = 0.5,
    this.hasSpecularBorder = true,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveRadius = borderRadius ?? BorderRadius.circular(16);
    final isDark = CupertinoTheme.brightnessOf(context) == Brightness.dark;

    final resolvedBg = backgroundColor ??
        AppColors.liquidGlassBg.resolveFrom(context);

    final resolvedBorderColor = borderColor ??
        AppColors.liquidGlassBorder.resolveFrom(context);

    return ClipRRect(
      borderRadius: effectiveRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: blurSigma,
          sigmaY: blurSigma,
        ),
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: resolvedBg,
            borderRadius: effectiveRadius,
            border: hasSpecularBorder
                ? Border.all(
                    color: resolvedBorderColor,
                    width: borderWidth,
                  )
                : null,
            boxShadow: isDark
                ? [
                    BoxShadow(
                      color: const Color(0x66000000),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: const Color(0x1A000000),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
          ),
          child: child,
        ),
      ),
    );
  }
}
