import 'package:anime_explore/presentation/top_anime/top_anime_page.dart';
import 'package:anime_explore/presentation/search/search_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedPage = 0;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: _bodyWidget()),
          PlatformNavBar(
            currentIndex: _selectedPage,
            cupertino: (context, platform) => CupertinoTabBarData(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              activeColor: Theme.of(context).primaryColor,
              inactiveColor: Theme.of(context).unselectedWidgetColor,
            ),
            itemChanged: _changePage,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                label: 'Top',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'Search',
              ),
            ],
          ),
          // BottomNavigationBar(
          //   currentIndex: _selectedPage,
          //   onTap: _changePage,
          //   items: const [
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.explore),
          //       label: 'Top',
          //     ),
          //     BottomNavigationBarItem(
          //       icon: Icon(Icons.search),
          //       label: 'Search',
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }

  Widget _bodyWidget() {
    return PageView(
      controller: _pageController,
      children: const [
        TopAnimePage(),
        SearchPage(),
      ],
    );
  }

  void _changePage(int page) {
    setState(() {
      _selectedPage = page;
    });
    _pageController.jumpToPage(page);
  }
}
