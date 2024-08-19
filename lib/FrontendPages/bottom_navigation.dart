import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  BottomNavigation({required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Color.fromARGB(255, 0, 94, 132),
      selectedItemColor: Colors.white,
      unselectedItemColor: Color.fromARGB(255, 57, 199, 149),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.article),
          label: 'News',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.store),
          label: 'Shops',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.people),
          label: 'Social',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      onTap: onItemTapped,
    );
  }
}
