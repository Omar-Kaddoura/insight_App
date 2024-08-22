import 'package:flutter/material.dart';
import 'package:insight/BottomNavigationBarPages/News.dart';
import 'package:insight/BottomNavigationBarPages/Social.dart';
import 'package:insight/BottomNavigationBarPages/Shop.dart';
import 'package:insight/BottomNavigationBarPages/Profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:insight/messaging/user_list.dart';
import 'package:insight/components/up_logo.dart';

class HomePageWithNavigation extends StatefulWidget {
  const HomePageWithNavigation({Key? key}) : super(key: key);

  @override
  _HomePageWithNavigationState createState() => _HomePageWithNavigationState();
}

class _HomePageWithNavigationState extends State<HomePageWithNavigation> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: <Widget>[
          News(),
          UsersListScreen(),
          Shop(),
          ProfilePage(), // Remove the logout function
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
