import 'package:anime_explore/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class TNavigationBarTheme {
  const TNavigationBarTheme._();

  static NavigationBarThemeData darkTheme = NavigationBarThemeData(
    backgroundColor: TColors.black,
    indicatorColor: TColors.primary.withOpacity(0.4),
  );
}
