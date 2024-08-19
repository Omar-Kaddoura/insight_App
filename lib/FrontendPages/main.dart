import 'package:flutter/material.dart';
import 'home_page.dart';

void main() {
  runApp(FrontEnd());
}

class FrontEnd extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color.fromARGB(255, 0, 94, 132),
          selectedItemColor: Colors.white,
          unselectedItemColor: Color.fromARGB(255, 57, 199, 149),
        ),
      ),
      home: HomePage(),
    );
  }
}
