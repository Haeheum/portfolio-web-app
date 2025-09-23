import 'package:flutter/material.dart';

class ExtensionColors extends ThemeExtension<ExtensionColors> {
  const ExtensionColors({
    required this.skyColor,
    required this.rainColor,
    required this.cardBackgroundColor,
    required this.backgroundColor,
    required this.backgroundColor2,
    required this.textColor,
    required this.warningColor,
    required this.terminalAppBarColor,
    required this.terminalAppBarTextColor,
    required this.terminalUnfocusedAppBarColor,
    required this.terminalUnfocusedAppBarTextColor,
    required this.terminalBackgroundColor,
    required this.terminalTextColor,
    required this.terminalCursorColor,
  });

  final Color? skyColor;
  final Color? rainColor;
  final Color? cardBackgroundColor;
  final Color? backgroundColor;
  final Color? backgroundColor2;
  final Color? textColor;
  final Color? warningColor;

  final Color? terminalAppBarColor;
  final Color? terminalAppBarTextColor;
  final Color? terminalUnfocusedAppBarColor;
  final Color? terminalUnfocusedAppBarTextColor;

  final Color? terminalBackgroundColor;
  final Color? terminalTextColor;
  final Color? terminalCursorColor;

  @override
  ExtensionColors copyWith({
    Color? skyColor,
    Color? rainColor,
    Color? cardBackgroundColor,
    Color? backgroundColor,
    Color? backgroundColor2,
    Color? textColor,
    Color? matrixShadowColor,
    Color? warningColor,
    Color? terminalAppBarColor,
    Color? terminalAppBarTextColor,
    Color? terminalUnfocusedAppBarColor,
    Color? terminalUnfocusedAppBarTextColor,
    Color? terminalBackgroundColor,
    Color? terminalTextColor,
    Color? terminalCursorColor,
  }) {
    return ExtensionColors(
      skyColor: skyColor ?? this.skyColor,
      rainColor: rainColor ?? this.rainColor,
      cardBackgroundColor: cardBackgroundColor ?? this.cardBackgroundColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      backgroundColor2: backgroundColor2 ?? this.backgroundColor2,
      textColor: textColor ?? this.textColor,
      warningColor: warningColor ?? this.warningColor,
      terminalAppBarColor: terminalAppBarColor ?? this.terminalAppBarColor,
      terminalAppBarTextColor:
          terminalAppBarTextColor ?? this.terminalAppBarTextColor,
      terminalUnfocusedAppBarColor:
          terminalUnfocusedAppBarColor ?? this.terminalUnfocusedAppBarColor,
      terminalUnfocusedAppBarTextColor: terminalUnfocusedAppBarTextColor ??
          this.terminalUnfocusedAppBarTextColor,
      terminalBackgroundColor:
          terminalBackgroundColor ?? this.terminalBackgroundColor,
      terminalTextColor: terminalTextColor ?? this.terminalTextColor,
      terminalCursorColor: terminalCursorColor ?? this.terminalCursorColor,
    );
  }

  @override
  ExtensionColors lerp(ExtensionColors? other, double t) {
    if (other is! ExtensionColors) {
      return this;
    }
    return ExtensionColors(
      skyColor: Color.lerp(skyColor, other.skyColor, t),
      rainColor: Color.lerp(rainColor, other.rainColor, t),
      cardBackgroundColor:
          Color.lerp(cardBackgroundColor, other.cardBackgroundColor, t),
      backgroundColor: Color.lerp(backgroundColor, other.backgroundColor, t),
      backgroundColor2: Color.lerp(backgroundColor2, other.backgroundColor2, t),
      textColor: Color.lerp(textColor, other.textColor, t),
      warningColor: Color.lerp(warningColor, other.warningColor, t),
      terminalAppBarColor:
          Color.lerp(terminalAppBarColor, other.terminalAppBarColor, t),
      terminalAppBarTextColor:
          Color.lerp(terminalAppBarTextColor, other.terminalAppBarTextColor, t),
      terminalUnfocusedAppBarColor: Color.lerp(
          terminalUnfocusedAppBarColor, other.terminalUnfocusedAppBarColor, t),
      terminalUnfocusedAppBarTextColor: Color.lerp(
          terminalUnfocusedAppBarTextColor,
          other.terminalUnfocusedAppBarTextColor,
          t),
      terminalBackgroundColor:
          Color.lerp(terminalBackgroundColor, other.terminalBackgroundColor, t),
      terminalTextColor:
          Color.lerp(terminalTextColor, other.terminalTextColor, t),
      terminalCursorColor:
          Color.lerp(terminalCursorColor, other.terminalCursorColor, t),
    );
  }
}
