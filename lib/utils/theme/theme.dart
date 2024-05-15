import 'package:anime_explore/utils/constants/colors.dart';
import 'package:anime_explore/utils/theme/app_bar_theme.dart';
import 'package:anime_explore/utils/theme/dialog_theme.dart';
import 'package:anime_explore/utils/theme/dropdown_button_form_field_theme.dart';
import 'package:anime_explore/utils/theme/elevated_button_theme.dart';
import 'package:anime_explore/utils/theme/input_decoration_theme.dart';
import 'package:anime_explore/utils/theme/navigation_bar_theme.dart';
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
    dropdownMenuTheme: TDropdownButtonFormFieldTheme.darkTheme,
    elevatedButtonTheme: TElevatedButtonTheme.darkTheme,
    dialogTheme: TDialogTheme.darkTheme,
    appBarTheme: TAppBarTheme.darkTheme,
    inputDecorationTheme: TInputDecorationTheme.darkTheme,
    navigationBarTheme: TNavigationBarTheme.darkTheme,
  );
}
