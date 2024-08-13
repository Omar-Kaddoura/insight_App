import 'package:flutter/material.dart';
import 'package:insight/Pages/Authentication/register_page.dart';
import 'package:insight/Pages/Authentication/login_page.dart';

import 'Pages/Authentication/WelcomePage.dart';

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
      home: const WelcomePage(),
    );
  }
}
