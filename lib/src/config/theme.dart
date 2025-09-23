import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'theme_extension.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: const Color(0xFF2184DC),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Color(0xFF2F2E36)),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: Color(0xFF2F2E36),
    backgroundColor: Color(0xFFF5CE56),
  ),
  iconTheme: const IconThemeData(color: Color(0xFF2F2E36)),
  scaffoldBackgroundColor: const Color(0xFFFFE9A6),
  sliderTheme: const SliderThemeData(
    activeTrackColor: Color(0xFFF5CE56),
    inactiveTrackColor: Color(0xFFA9A9A9),
    thumbColor: Color(0xFFF5CE56),
  ),
  textTheme: GoogleFonts.juaTextTheme(),
  tooltipTheme: TooltipThemeData(
    textStyle: GoogleFonts.jua().copyWith(
      fontSize: 20,
      color: const Color(0xFFEDEBEE),
    ),
  ),
  extensions: const [
    ExtensionColors(
      skyColor: Color(0xFF51A4D6),
      rainColor: Color(0xCBFFFFFF),
      cardBackgroundColor: Color(0xFFFFB965),
      backgroundColor: Color(0xFFFFE9A6),
      backgroundColor2: Color(0xFFFAA162),
      textColor: Color(0xFF2F2E36),
      warningColor: Color(0xFFE53935),
      terminalAppBarColor: Color(0xFFF0EEE9),
      terminalAppBarTextColor: Color(0xFF827F7D),
      terminalUnfocusedAppBarColor: Color(0xFFE4E2DF),
      terminalUnfocusedAppBarTextColor: Color(0xFFA7A5A2),
      terminalBackgroundColor: Color(0xFFF5F5F5),
      terminalTextColor: Color(0xFF020202),
      terminalCursorColor: Color(0xFF989998),
    ),
  ],
);

ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: const Color(0xFF8AC1EF),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Color(0xFFEDEBEE)),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    foregroundColor: Color(0xFFEDEBEE),
    backgroundColor: Color(0xFF040D17),
  ),
  iconTheme: const IconThemeData(color: Color(0xFFEDEBEE)),
  scaffoldBackgroundColor: const Color(0xFF3B3B3B),
  sliderTheme: const SliderThemeData(
    activeTrackColor: Color(0xFF466C93),
    inactiveTrackColor: Color(0xFFA9A9A9),
    thumbColor: Color(0xFF466C93),
  ),
  textTheme: GoogleFonts.juaTextTheme(),
  tooltipTheme: TooltipThemeData(
    textStyle: GoogleFonts.jua().copyWith(
      fontSize: 20,
      color: const Color(0xFF2F2E36),
    ),
  ),
  extensions: const [
    ExtensionColors(
      skyColor: Color(0xFF152F52),
      rainColor: Color(0x99F4F4F5),
      cardBackgroundColor: Color(0xFF343443),
      backgroundColor: Color(0xFF3B3B3B),
      backgroundColor2: Color(0xFF2A2D30),
      textColor: Color(0xFFEDEBEE),
      warningColor: Color(0xFFEF9A9A),
      terminalAppBarColor: Color(0xFF43403B),
      terminalAppBarTextColor: Color(0xFFA8A6A1),
      terminalUnfocusedAppBarColor: Color(0xFF37352E),
      terminalUnfocusedAppBarTextColor: Color(0xFF77726C),
      terminalBackgroundColor: Color(0xFF20201E),
      terminalTextColor: Color(0xFFEEEEEF),
      terminalCursorColor: Color(0xFF979899),
    ),
  ],
);
