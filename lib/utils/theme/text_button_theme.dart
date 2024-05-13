import 'package:anime_explore/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TTextButtonTheme {
  TTextButtonTheme._();

  static TextButtonThemeData darkTextButtonTheme = TextButtonThemeData(
      style: ButtonStyle(
    foregroundColor: MaterialStateProperty.all(TColors.primary),
    overlayColor: MaterialStateProperty.all(TColors.primary.withOpacity(0.1)),
  ));
}
