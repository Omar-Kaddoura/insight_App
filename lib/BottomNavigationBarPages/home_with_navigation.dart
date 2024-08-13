import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:insight/BottomNavigationBarPages/News.dart';
import 'package:insight/BottomNavigationBarPages/Profile.dart';
import 'package:insight/BottomNavigationBarPages/Shop.dart';
import 'package:insight/BottomNavigationBarPages/Social.dart';

class HomePageWithNavigation extends StatefulWidget {
  @override
  _HomePageWithNavigationState createState() => _HomePageWithNavigationState();
}

class _HomePageWithNavigationState extends State<HomePageWithNavigation> {
  final _pageController = PageController();
  int _selectedIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: const <Widget>[
          News(),
          Social(),
          Shop(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.blueGrey,
        buttonBackgroundColor: Colors.grey,
        color: const Color(0xFF005E84),
        height: 65,
        index: _selectedIndex,
        items: const <Widget>[
          Icon(
            Icons.article,
            size: 35,
            color: Colors.green,
          ),
          Icon(
            Icons.people,
            size: 35,
            color: Colors.green,
          ),
          Icon(
            Icons.shopping_cart,
            size: 35,
            color: Colors.green,
          ),
          Icon(
            Icons.person,
            size: 35,
            color: Colors.green,
          ),
        ],
        onTap: (index) {
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        },
      ),
    );
  }
}
