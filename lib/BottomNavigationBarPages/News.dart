import 'package:flutter/material.dart';

class News extends StatelessWidget {
  const News({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.newspaper,
            size: 120,
            color: Colors.red,
          ),
          Text(
            'News Page',
            style: TextStyle(
                color: Colors.red, fontSize: 30, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}