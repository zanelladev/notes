import 'package:flutter/material.dart';

class NotesThemeColors {
  static const black = Color(0xff060807);
  static const darkGrey = Color(0xFF131718);
  static const secondaryDarkGrey = Color(0xff1d1e20);
  static const secondaryGrey = Color(0xff5d5e60);
  static const secondaryLightGrey = Color(0xff9ea1a0);
  static const salmon = Color(0xffcd4f4f);
  static const white = Color(0xfff0f2f1);
  static const error = Color(0xffCC1100);
  static const lightBlue = Color(0xffd6dfde);
}

class NotesColorScheme extends ColorScheme {
  final Color darkBackground;
  final Color secondaryDarkColor;
  final Color lightBackground;
  final Color secondaryGrey;
  final Color secondaryLightGrey;

  const NotesColorScheme({
    super.brightness = Brightness.dark,
    super.primary = NotesThemeColors.salmon,
    super.onPrimary = NotesThemeColors.darkGrey,
    super.secondary = NotesThemeColors.darkGrey,
    super.onSecondary = NotesThemeColors.lightBlue,
    super.error = NotesThemeColors.error,
    super.onError = NotesThemeColors.white,
    super.background = NotesThemeColors.darkGrey,
    super.onBackground = NotesThemeColors.white,
    super.surface = NotesThemeColors.white,
    super.onSurface = NotesThemeColors.darkGrey,
    this.darkBackground = NotesThemeColors.darkGrey,
    this.lightBackground = NotesThemeColors.white,
    this.secondaryDarkColor = NotesThemeColors.secondaryDarkGrey,
    this.secondaryGrey = NotesThemeColors.secondaryGrey,
    this.secondaryLightGrey = NotesThemeColors.secondaryLightGrey,
    super.surfaceVariant = NotesThemeColors.secondaryDarkGrey,
  });
}
