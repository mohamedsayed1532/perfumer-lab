import 'package:cupertino_ui/cupertino_ui.dart';
import 'app_colors.dart';

/// Apple HIG SF Pro typographic scale for mobile apps.
class AppTypography {
  AppTypography._();

  static TextStyle largeTitle(BuildContext context) => TextStyle(
        fontFamily: '.SF Pro Display',
        fontSize: 34,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.37,
        color: AppColors.label.resolveFrom(context),
      );

  static TextStyle title1(BuildContext context) => TextStyle(
        fontFamily: '.SF Pro Display',
        fontSize: 28,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.36,
        color: AppColors.label.resolveFrom(context),
      );

  static TextStyle title2(BuildContext context) => TextStyle(
        fontFamily: '.SF Pro Display',
        fontSize: 22,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.35,
        color: AppColors.label.resolveFrom(context),
      );

  static TextStyle title3(BuildContext context) => TextStyle(
        fontFamily: '.SF Pro Text',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.38,
        color: AppColors.label.resolveFrom(context),
      );

  static TextStyle headline(BuildContext context) => TextStyle(
        fontFamily: '.SF Pro Text',
        fontSize: 17,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.41,
        color: AppColors.label.resolveFrom(context),
      );

  static TextStyle body(BuildContext context) => TextStyle(
        fontFamily: '.SF Pro Text',
        fontSize: 17,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.41,
        color: AppColors.label.resolveFrom(context),
      );

  static TextStyle callout(BuildContext context) => TextStyle(
        fontFamily: '.SF Pro Text',
        fontSize: 16,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.32,
        color: AppColors.secondaryLabel.resolveFrom(context),
      );

  static TextStyle subheadline(BuildContext context) => TextStyle(
        fontFamily: '.SF Pro Text',
        fontSize: 15,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.24,
        color: AppColors.secondaryLabel.resolveFrom(context),
      );

  static TextStyle footnote(BuildContext context) => TextStyle(
        fontFamily: '.SF Pro Text',
        fontSize: 13,
        fontWeight: FontWeight.w400,
        letterSpacing: -0.08,
        color: AppColors.tertiaryLabel.resolveFrom(context),
      );

  static TextStyle caption1(BuildContext context) => TextStyle(
        fontFamily: '.SF Pro Text',
        fontSize: 12,
        fontWeight: FontWeight.w400,
        letterSpacing: 0.0,
        color: AppColors.tertiaryLabel.resolveFrom(context),
      );

  static TextStyle precisionNumber(BuildContext context, {double fontSize = 24}) =>
      TextStyle(
        fontFamily: '.SF Pro Rounded',
        fontSize: fontSize,
        fontWeight: FontWeight.w700,
        fontFeatures: const [FontFeature.tabularFigures()],
        color: AppColors.label.resolveFrom(context),
      );
}
