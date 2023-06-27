import 'package:film_explorer/home_content.dart';
import 'package:film_explorer/search.dart';
import 'package:film_explorer/shared/theme.dart';
import 'package:film_explorer/watch_list.dart';
import 'package:flutter/material.dart';

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
  final List<Widget> _pages = [
    const HomeContent(),
    const Search(),
    const WatchList(),
  ];

  final List<AppBar?> _appBars = [
    null, // Halaman pertama tanpa AppBar
    AppBar(
      title: const Text('Search'),
    ),
    AppBar(
      title: const Text('Watch list'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBars[widget.selectedIndex],
      bottomNavigationBar: BottomAppBar(
        color: blueColor,
        shape: const CircularNotchedRectangle(),
        clipBehavior: Clip.antiAlias,
        notchMargin: 6,
        elevation: 0,
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: blueColor, // Ganti dengan warna border yang diinginkan
                width: 1.0, // Ganti dengan ketebalan border yang diinginkan
              ),
            ),
          ),
          child: BottomNavigationBar(
            currentIndex: widget.selectedIndex,
            onTap: (int index) {
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
        ),
      ),
      body: _pages[widget.selectedIndex],
    );
  }
}
