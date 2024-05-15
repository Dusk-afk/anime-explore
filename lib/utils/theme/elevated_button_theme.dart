import 'package:anime_explore/utils/constants/colors.dart';
import 'package:anime_explore/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TElevatedButtonTheme {
  TElevatedButtonTheme._();

  static final darkTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      foregroundColor: TColors.textPrimary,
      backgroundColor: TColors.primary,
      disabledForegroundColor: TColors.darkGrey,
      disabledBackgroundColor: TColors.darkerGrey,
      side: const BorderSide(color: TColors.primary),
      padding: const EdgeInsets.symmetric(
        vertical: TSizes.buttonHeight,
        horizontal: 20,
      ),
      textStyle: const TextStyle(
        fontSize: 16,
        color: TColors.textPrimary,
        fontWeight: FontWeight.w600,
      ),
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(TSizes.buttonRadius))),
    ),
  );
}
