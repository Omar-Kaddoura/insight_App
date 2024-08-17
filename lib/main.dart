import 'package:flutter/material.dart';
import 'Pages/Authentication/register_page.dart';
import 'Pages/Authentication/login_page.dart';
import 'Pages/Authentication/WelcomePage.dart';
import 'Admin/AdminBottomNavigationBarPages/Admin_home.dart';
import 'BottomNavigationBarPages/home_with_navigation.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Registration',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(),
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        '/student_home': (context) => HomePageWithNavigation(),
        '/admin_home': (context) => AdminHome(),
      },
    );
  }
}
