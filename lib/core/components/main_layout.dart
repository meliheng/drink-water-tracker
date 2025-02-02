import 'package:flutter/material.dart';
import 'package:workmanagerexample/core/components/bottom_navigation_bar.dart';
import 'package:workmanagerexample/features/profile/presentation/pages/profile_page.dart';
import 'package:workmanagerexample/features/water/presentation/pages/history_page.dart';
import 'package:workmanagerexample/features/water/presentation/pages/home_page.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({super.key});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  final List<Widget> _pages = [const HomePage(), HistoryPage(), ProfilePage()];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_currentIndex],
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(24.0),
            child: CustomBottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: _onTabTapped,
            ),
          ),
        ),
      ),
    );
  }
}
