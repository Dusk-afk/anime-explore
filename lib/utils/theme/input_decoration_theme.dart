import 'package:anime_explore/utils/constants/colors.dart';
import 'package:anime_explore/utils/constants/sizes.dart';
import 'package:flutter/material.dart';

class TInputDecorationTheme {
  const TInputDecorationTheme._();

  static InputDecorationTheme darkTheme = InputDecorationTheme(
    prefixIconColor: TColors.darkGrey,
    suffixIconColor: TColors.darkGrey,
    constraints: const BoxConstraints.expand(height: TSizes.inputFieldHeight),
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 0),
    labelStyle: const TextStyle()
        .copyWith(fontSize: TSizes.fontSizeMd, color: TColors.white),
    hintStyle: const TextStyle()
        .copyWith(fontSize: TSizes.fontSizeSm, color: TColors.darkGrey),
    floatingLabelStyle:
        const TextStyle().copyWith(color: TColors.white.withOpacity(0.8)),
    filled: true,
    fillColor: const Color.fromRGBO(43, 43, 46, 1),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: TColors.transparent),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: TColors.transparent),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: TColors.transparent),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: TColors.error),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: TColors.warning),
    ),
  );
}
