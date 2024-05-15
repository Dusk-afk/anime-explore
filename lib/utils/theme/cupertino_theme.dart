import 'package:anime_explore/utils/constants/colors.dart';
import 'package:flutter/cupertino.dart';

class TCupertinoTheme {
  TCupertinoTheme._();

  static CupertinoThemeData darkTheme = const CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: TColors.primary,
    textTheme: CupertinoTextThemeData(
      primaryColor: Color(0xFFFFFFFF),
      textStyle: TextStyle(
        color: Color(0xFFFFFFFF),
      ),
    ),
    barBackgroundColor: TColors.darkBlack,
    scaffoldBackgroundColor: TColors.darkBlack,
  );
}
