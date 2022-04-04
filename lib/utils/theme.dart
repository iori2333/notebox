import 'package:flutter/material.dart';

extension AppTheme on BuildContext {
  ThemeData get theme => Theme.of(this);

  Color get primaryColor => theme.primaryColor;

  ColorScheme get colorScheme => theme.colorScheme;

  IconThemeData get iconTheme => theme.iconTheme;

  TextTheme get textTheme => theme.textTheme;

  Color get inversePrimary => theme.colorScheme.inversePrimary;
}

const lightSwatch = MaterialColor(0xFFdd4237, {
  900: Color(0xFFae2a20),
  800: Color(0xFFbe332a),
  700: Color(0xFFcb3931),
  600: Color(0xFFdd4237),
  500: Color(0xFFec4b38),
  400: Color(0xFFe85951),
  300: Color(0xFFdf7674),
  200: Color(0xFFea9c9a),
  100: Color(0xFFfcced2),
  50: Color(0xFFfeebee),
});

var lightTheme = ThemeData.from(
  colorScheme: const ColorScheme.light(primary: lightSwatch),
).copyWith(
  toggleableActiveColor: lightSwatch,
  tooltipTheme: TooltipThemeData(
    decoration: BoxDecoration(
      color: lightSwatch,
      borderRadius: BorderRadius.circular(4),
    ),
  ),
);

var darkTheme = ThemeData.from(
  colorScheme: ColorScheme.dark(
    background: Color.alphaBlend(Colors.black87, Colors.white),
    onBackground: Color.alphaBlend(Colors.white54, Colors.black),
    surface: Color.alphaBlend(Colors.black87, Colors.white),
    onSurface: Color.alphaBlend(Colors.white70, Colors.black),
    primary: lightSwatch,
    secondary: lightSwatch[300]!,
    tertiary: lightSwatch[100],
    onPrimary: const Color(0xFFDDDDDD),
  ),
).copyWith(
  toggleableActiveColor: lightSwatch,
  tooltipTheme: const TooltipThemeData(
    waitDuration: Duration(milliseconds: 1000),
  ),
);
