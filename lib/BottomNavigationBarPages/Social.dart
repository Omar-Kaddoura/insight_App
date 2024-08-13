import 'package:flutter/material.dart';

class Social extends StatelessWidget {
  const Social({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.blue),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: const [
          Icon(
            Icons.phone,
            size: 120,
            color: Colors.white,
          ),
          Text(
            'Social Page',
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}