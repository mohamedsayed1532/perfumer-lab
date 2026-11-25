import 'package:cupertino_ui/cupertino_ui.dart';
import 'app_colors.dart';

/// Analytical lab surface container matching the StitchMCP design system.
///
/// Renders crisp `#181C23`/`#1C2027` lab cards with `#3E484F` hairline borders
/// without heavy GPU BackdropFilters inside scroll lists.
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
    final radius = borderRadius ?? BorderRadius.circular(14);
    final isDark = CupertinoTheme.brightnessOf(context) == Brightness.dark;

    final effectiveBorderColor =
        borderColor ?? AppColors.cardBorder.resolveFrom(context);

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: backgroundColor ??
            (isDark ? const Color(0xFF181C23) : const Color(0xFFFFFFFF)),
        borderRadius: radius,
        border: hasSpecularBorder
            ? Border.all(
                color: effectiveBorderColor,
                width: borderWidth,
              )
            : null,
        boxShadow: customShadow ??
            (isDark
                ? const [
                    BoxShadow(
                      color: Color(0x33000000),
                      blurRadius: 12,
                      offset: Offset(0, 4),
                    ),
                  ]
                : const [
                    BoxShadow(
                      color: Color(0x0D0F141A),
                      blurRadius: 10,
                      offset: Offset(0, 3),
                    ),
                  ]),
      ),
      child: child,
    );
  }
}

/// Deep slate laboratory background canvas (`#0F141A` in dark mode).
class LiquidGlassBackground extends StatelessWidget {
  final Widget child;
  const LiquidGlassBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.systemBackground.resolveFrom(context),
      child: child,
    );
  }
}
