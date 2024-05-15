import 'package:anime_explore/presentation/main/main_page.dart';
import 'package:anime_explore/utils/theme/cupertino_theme.dart';
import 'package:anime_explore/utils/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: TCupertinoTheme.darkTheme,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        darkTheme: TAppTheme.darkTheme,
        themeMode: ThemeMode.dark,
        routes: {
          '/': (context) => const MainPage(),
        },
      ),
    );
  }
}
