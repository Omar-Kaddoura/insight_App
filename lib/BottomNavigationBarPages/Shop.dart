import 'package:flutter/material.dart';

class Shop extends StatelessWidget {
  const Shop({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.deepPurpleAccent),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.camera,
            size: 120,
            color: Colors.white,
          ),
          Text(
            'Shop Page',
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}