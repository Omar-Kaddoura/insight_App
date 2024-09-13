import 'package:flutter/material.dart';
import 'package:insight/BottomNavigationBarPages/News/News.dart';
import 'package:insight/BottomNavigationBarPages/Social.dart';
import 'package:insight/BottomNavigationBarPages/Shop.dart';
import 'package:insight/BottomNavigationBarPages/Profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:insight/messaging/user_list.dart';
import 'package:insight/components/up_logo.dart';
import 'package:insight/BottomNavigationBarPages/Social/Filter_Page.dart';
import 'package:insight/messaging/user_list.dart';
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
  Widget _buildNavItem(IconData icon, String label) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          size: 20,
          color: Color(0xFFebf5f7),
        ),
        Text(
          label,
          style: TextStyle(
            color: Color(0xFFebf5f7),
            fontSize: 9,
          ),
        ),
      ],
    );
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
          FilterPage(),
          Shop(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        buttonBackgroundColor: Color(0xFF005E84),
        color: const Color(0xFF005E84),
        height: 75,
        index: _selectedIndex,
        items:  <Widget>[
          _buildNavItem(Icons.article, 'News'),
          _buildNavItem(Icons.article, 'Events'),
          _buildNavItem(Icons.people, 'Social'),
          _buildNavItem(Icons.shopping_cart, 'Shop'),
          _buildNavItem(Icons.person, 'Profile'),
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
