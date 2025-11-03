import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF108fdc); // azul padrão
  static const Color secondary = Color(0xFF0d3980);
  static const Color darkBlue = Color(0xFF021648);
  static const Color accent = Color(0xFF407a9f);

  static const Color background = Color(0xFFF5F5F5);
  static const Color text = Color(0xFF212121);
  static const Color textLight = Color(0xFF757575);

  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFFC107);
  static const Color error = Color(0xFFF44336);

  static const BoxDecoration backgroundLinearGradientLight = BoxDecoration(
    gradient: LinearGradient(
      colors: <Color>[AppColors.primary, AppColors.darkBlue],
      begin: Alignment.topCenter,
    ),
  );

  static const BoxDecoration backgroundLinearGradientDark = BoxDecoration(
    gradient: LinearGradient(
      colors: <Color>[AppColors.secondary, AppColors.darkBlue],
      begin: Alignment.topCenter,
    ),
  );
}
