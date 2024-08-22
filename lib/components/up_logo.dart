import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Center(
        child: Image.asset(
          'assets/images/LogoHorizontal.jpeg',
          height: 50,
        ),
      ),
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.black),
      titleTextStyle: TextStyle(color: Colors.black),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
