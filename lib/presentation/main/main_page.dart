import 'package:anime_explore/presentation/top_anime/top_anime_page.dart';
import 'package:anime_explore/presentation/search/search_page.dart';
import 'package:anime_explore/utils/constants/colors.dart';
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
      bottomNavigationBar: PlatformNavBar(
        currentIndex: _selectedPage,
        cupertino: (context, platform) => CupertinoTabBarData(
          backgroundColor: TColors.black,
          activeColor: Theme.of(context).primaryColor,
          inactiveColor: Theme.of(context).unselectedWidgetColor,
        ),
        material3: (context, platform) => MaterialNavigationBarData(items: [
          const NavigationDestination(
            icon: Icon(Icons.explore),
            selectedIcon: Icon(
              Icons.explore,
              color: TColors.white,
            ),
            label: 'Top',
          ),
          const NavigationDestination(
            icon: Icon(Icons.search),
            selectedIcon: Icon(
              Icons.search,
              color: TColors.white,
            ),
            label: 'Search',
          ),
        ]),
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
      body: Column(
        children: [
          Expanded(child: _bodyWidget()),
        ],
      ),
    );
  }

  Widget _bodyWidget() {
    return PageView(
      physics: const NeverScrollableScrollPhysics(),
      controller: _pageController,
      children: const [
        TopAnimePage(),
        SearchPage(),
      ],
    );
  }

  void _changePage(int page) {
    if (page != 1) {
      FocusScope.of(context).unfocus();
    }
    setState(() {
      _selectedPage = page;
    });
    _pageController.jumpToPage(page);
  }
}
