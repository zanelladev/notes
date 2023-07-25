import 'package:dependencies/dependencies.dart';
import 'package:flutter/material.dart';

import '../colors/notes_color_scheme.dart';
import '../extensions/notes_text_styles_extension.dart';

class NotesTheme {
  static final light = ThemeData(
    useMaterial3: true,
    colorScheme: const NotesColorScheme(),
    extensions: [
      NotesTextStylesExtension(
        headlineSLight: GoogleFonts.montserrat(
          fontSize: 32,
          color: NotesThemeColors.white,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8,
        ),
        headlineSDark: GoogleFonts.montserrat(
          fontSize: 32,
          color: NotesThemeColors.black,
          fontWeight: FontWeight.bold,
          letterSpacing: 0.8,
        ),
        smallTextDark: GoogleFonts.montserrat(
          fontSize: 15,
          color: NotesThemeColors.darkGrey,
          fontWeight: FontWeight.w600,
        ),
        smallTextGrey: GoogleFonts.montserrat(
          fontSize: 14,
          color: NotesThemeColors.secondaryLightGrey,
          fontWeight: FontWeight.w500,
        ),
      ),
    ],
  );
}
