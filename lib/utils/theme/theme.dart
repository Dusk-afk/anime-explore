import 'package:anime_explore/utils/constants/colors.dart';
import 'package:anime_explore/utils/theme/text_button_theme.dart';
import 'package:anime_explore/utils/theme/text_theme.dart';
import 'package:flutter/material.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    disabledColor: TColors.grey,
    brightness: Brightness.dark,
    primaryColor: TColors.primary,
    textTheme: TTextTheme.darkTextTheme,
    scaffoldBackgroundColor: TColors.darkBlack,
    textButtonTheme: TTextButtonTheme.darkTextButtonTheme,
  );
}
