import 'package:anime_explore/utils/constants/colors.dart';
import 'package:anime_explore/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TDropdownButtonFormFieldTheme {
  const TDropdownButtonFormFieldTheme._();

  static DropdownMenuThemeData darkTheme = DropdownMenuThemeData(
    inputDecorationTheme: InputDecorationTheme(
      errorMaxLines: 2,
      prefixIconColor: TColors.darkGrey,
      suffixIconColor: TColors.darkGrey,
      // constraints: const BoxConstraints.expand(height: TSizes.inputFieldHeight),
      labelStyle: const TextStyle()
          .copyWith(fontSize: TSizes.fontSizeMd, color: TColors.white),
      hintStyle: const TextStyle()
          .copyWith(fontSize: TSizes.fontSizeSm, color: TColors.darkGrey),
      floatingLabelStyle:
          const TextStyle().copyWith(color: TColors.white.withOpacity(0.8)),
      border: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
        borderSide: const BorderSide(width: 1, color: TColors.white),
      ),
      enabledBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
        borderSide: const BorderSide(width: 1, color: TColors.white),
      ),
      focusedBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
        borderSide: const BorderSide(width: 1, color: TColors.primary),
      ),
      errorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
        borderSide: const BorderSide(width: 1, color: TColors.error),
      ),
      focusedErrorBorder: const OutlineInputBorder().copyWith(
        borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
        borderSide: const BorderSide(width: 2, color: TColors.warning),
      ),
    ),
  );
}
