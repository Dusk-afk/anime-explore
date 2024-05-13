import 'package:anime_explore/presentation/top_anime/top_anime_page.dart';
import 'package:anime_explore/presentation/search/search_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(child: _bodyWidget()),
          BottomNavigationBar(
            currentIndex: _selectedPage,
            onTap: (value) {
              setState(() {
                _selectedPage = value;
              });
            },
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
          )
        ],
      ),
    );
  }

  Widget _bodyWidget() {
    switch (_selectedPage) {
      case 1:
        return const SearchPage();
      default:
        return TopAnimePage(onSearch: () {
          setState(() {
            _selectedPage = 1;
          });
        });
    }
  }
}
