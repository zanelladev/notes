import 'package:flutter/material.dart';

class NotesTextStylesExtension extends ThemeExtension<NotesTextStylesExtension> {
  final TextStyle headlineSLight;
  final TextStyle headlineSDark;
  final TextStyle smallTextDark;
  final TextStyle smallTextGrey;

  const NotesTextStylesExtension({
    required this.headlineSLight,
    required this.headlineSDark,
    required this.smallTextDark,
    required this.smallTextGrey,
  });

  @override
  ThemeExtension<NotesTextStylesExtension> copyWith() {
    return this;
  }

  @override
  ThemeExtension<NotesTextStylesExtension> lerp(covariant ThemeExtension<NotesTextStylesExtension>? other, double t) {
    return this;
  }
}
