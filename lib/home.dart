import 'package:film_explorer/home_content.dart';
import 'package:film_explorer/search.dart';
import 'package:film_explorer/shared/theme.dart';
import 'package:film_explorer/watch_list.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  int selectedIndex;
  Home({
    super.key,
    this.selectedIndex = 0,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ScrollController controllerHome = ScrollController();
  final ScrollController controllerSearch = ScrollController();
  late List<Widget> _pages = [];

  final List<AppBar?> _appBars = [
    null, // Halaman pertama tanpa AppBar
    AppBar(
      title: const Text('Search'),
    ),
    AppBar(
      title: const Text('Watch list'),
    ),
  ];

  final PageStorageBucket bucket = PageStorageBucket();

  @override
  void initState() {
    super.initState();
    _pages = [
      HomeContent(
        key: const PageStorageKey('Page1'),
        controller: controllerHome,
      ),
      Search(
        key: const PageStorageKey('Page2'),
        controller: controllerSearch,
      ),
      const WatchList(
        key: PageStorageKey('Page3'),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBars[widget.selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: widget.selectedIndex,
        onTap: (int index) {
          if (widget.selectedIndex == index) {
            if (widget.selectedIndex == 0) {
              controllerHome.animateTo(
                0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            } else if (widget.selectedIndex == 1) {
              controllerSearch.animateTo(
                0,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }
          }

          setState(() {
            widget.selectedIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        backgroundColor: backgroundColor,
        selectedItemColor: blueColor,
        unselectedItemColor: grayColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        selectedLabelStyle: blueTextStyle.copyWith(
          fontSize: 12,
          fontWeight: medium,
        ),
        unselectedLabelStyle: grayTextStyle.copyWith(
          fontSize: 12,
          fontWeight: medium,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icon_home.png',
              width: 24,
              color: widget.selectedIndex == 0 ? blueColor : grayColor,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icon_search.png',
              width: 24,
              color: widget.selectedIndex == 1 ? blueColor : grayColor,
            ),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icon_watchlist.png',
              width: 24,
              color: widget.selectedIndex == 2 ? blueColor : grayColor,
            ),
            label: "Watch list",
          ),
        ],
      ),
      body: IndexedStack(
        index: widget.selectedIndex,
        children: _pages,
      ),
    );
  }
}
