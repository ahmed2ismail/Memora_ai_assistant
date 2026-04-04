import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppStyles {
  /// Core scaling engine. Prevents fonts from going 20% smaller than base or 20% larger.
  static double getResponsiveFontSize(BuildContext context, {required double fontSize}) {
    double width = MediaQuery.sizeOf(context).width;
    double scaleFactor = width < 600 ? width / 400 : width < 900 ? width / 700 : width / 1000;
    double responsiveFontSize = fontSize * scaleFactor;
    double lowerLimit = responsiveFontSize * 0.8;
    double upperLimit = responsiveFontSize * 1.2;
    return responsiveFontSize.clamp(lowerLimit, upperLimit);
  }

  // --- Dynamic Headlines (Plus Jakarta Sans) ---
  
  static TextStyle headline(BuildContext context, {double fontSize = 48, Color color = AppColors.onSurface, FontWeight weight = FontWeight.w900}) {
    return TextStyle(
      fontFamily: 'Plus Jakarta Sans',
      fontSize: getResponsiveFontSize(context, fontSize: fontSize),
      fontWeight: weight,
      color: color,
    );
  }

  // --- Dynamic Body Texts (Inter) ---

  static TextStyle body12(BuildContext context, {Color color = AppColors.onSurfaceVariant, FontWeight weight = FontWeight.normal}) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: getResponsiveFontSize(context, fontSize: 12),
      fontWeight: weight,
      color: color,
    );
  }

  static TextStyle body14(BuildContext context, {Color color = AppColors.onSurfaceVariant, FontWeight weight = FontWeight.normal}) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: getResponsiveFontSize(context, fontSize: 14),
      fontWeight: weight,
      color: color,
    );
  }

  static TextStyle body16(BuildContext context, {Color color = AppColors.onSurface, FontWeight weight = FontWeight.bold}) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontWeight: weight,
      color: color,
    );
  }

  static TextStyle body24(BuildContext context, {Color color = AppColors.onSurface, FontWeight weight = FontWeight.bold}) {
    return TextStyle(
      fontFamily: 'Inter',
      fontSize: getResponsiveFontSize(context, fontSize: 24),
      fontWeight: weight,
      color: color,
    );
  }

  static TextStyle custom(BuildContext context, {
    required double fontSize,
    Color color = AppColors.onSurface,
    FontWeight weight = FontWeight.normal,
    String? fontFamily,
    double? letterSpacing,
  }) {
    return TextStyle(
      fontFamily: fontFamily ?? 'Inter',
      fontSize: getResponsiveFontSize(context, fontSize: fontSize),
      fontWeight: weight,
      color: color,
      letterSpacing: letterSpacing,
    );
  }
}
