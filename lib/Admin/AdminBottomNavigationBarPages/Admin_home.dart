import 'package:flutter/material.dart';
import 'Admin_Social.dart';
import 'Admin_news.dart';
import 'Admin_shop.dart';
import 'Admin_Profile.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  _AdminHome createState() => _AdminHome();
}

class _AdminHome extends State<AdminHome> {
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
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: <Widget>[
          AdminNews(),
          AdminSocial(),
          AdminShop(),
          AdminProfile(), // Remove the logout function
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
