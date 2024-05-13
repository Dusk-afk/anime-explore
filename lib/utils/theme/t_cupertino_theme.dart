import 'package:flutter/cupertino.dart';

class TCupertinoTheme {
  TCupertinoTheme._();

  static CupertinoThemeData lightTheme = const CupertinoThemeData(
    brightness: Brightness.light,
    primaryColor: Color(0xFF007AFF),
    textTheme: CupertinoTextThemeData(
      primaryColor: Color(0xFF000000),
      textStyle: TextStyle(
        color: Color(0xFF000000),
      ),
    ),
  );

  static CupertinoThemeData darkTheme = const CupertinoThemeData(
    brightness: Brightness.dark,
    primaryColor: Color(0xFF007AFF),
    textTheme: CupertinoTextThemeData(
      primaryColor: Color(0xFFFFFFFF),
      textStyle: TextStyle(
        color: Color(0xFFFFFFFF),
      ),
    ),
  );
}
