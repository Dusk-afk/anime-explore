import 'package:anime_explore/presentation/favorite/favorite_page.dart';
import 'package:anime_explore/presentation/home/home_page.dart';
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

  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      appBar: PlatformAppBar(
        title: const Text('Flutter Demo'),
        trailingActions: [
          PlatformIconButton(
            icon: const Icon(Icons.search),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          const SizedBox(height: 100),
          Expanded(child: _bodyWidget()),
          PlatformNavBar(
            currentIndex: _selectedPage,
            itemChanged: (value) {
              setState(() {
                _selectedPage = value;
              });
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: 'Search'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite_rounded), label: 'Favouites'),
            ],
          )
        ],
      ),
    );
  }

  Widget _bodyWidget() {
    switch (_selectedPage) {
      case 0:
        return const HomePage();
      case 1:
        return const SearchPage();
      case 2:
        return const FavoritePage();
      default:
        return const HomePage();
    }
  }
}
