import 'package:flutter/material.dart';

MaterialColor createMaterialColor(Color color) {
  final List<double> strengths = <double>[.05];
  final Map<int, Color> swatch = <int, Color>{};
  final int primary = color.value;
  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    final double opacity = ds < 0 ? 0 : ds;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      primary & 0xFF,
      (primary >> 8) & 0xFF,
      (primary >> 16) & 0xFF,
      opacity,
    );
  });
  return MaterialColor(color.value, swatch);
}
