import 'package:flutter/material.dart';
import 'package:tradinal_game/pages/history_screen.dart';
import 'package:tradinal_game/pages/home_screen.dart';
import 'package:tradinal_game/pages/profile_screen.dart';
import 'package:tradinal_game/pages/search_screen.dart';

class MainWrapper extends StatefulWidget {
  const MainWrapper({super.key});

  @override
  State<MainWrapper> createState() => _MainWrapperState();
}

class _MainWrapperState extends State<MainWrapper> {
  int _selectedIndex = 0;

  // These are the screens for each tab
  final List<Widget> _pages = [
    const HomeScreen(),
    const SearchScreen(),
    const HistoryScreen(), // Placeholder
    const ProfileScreen(), // Placeholder
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // The body updates based on which icon you click
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        height: 85,
        decoration: const BoxDecoration(
          color: Color(0xff800000), // Dark Red
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _navItem(Icons.home, 0),
            _navItem(Icons.search, 1),
            _navItem(Icons.history, 2),
            _navItem(Icons.person, 3),
          ],
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, int index) {
    bool isActive = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index; // Rebuilds the UI to show the new page
        });
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 30,
            color: isActive ? const Color(0xffFFD700) : Colors.white60,
          ),
          if (isActive)
            Container(
              margin: const EdgeInsets.only(top: 5),
              height: 3,
              width: 25,
              decoration: BoxDecoration(
                color: const Color(0xffFFD700), // Gold line for active tab
                borderRadius: BorderRadius.circular(10),
              ),
            ),
        ],
      ),
    );
  }
}
