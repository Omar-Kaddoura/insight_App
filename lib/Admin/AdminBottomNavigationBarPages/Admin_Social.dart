import 'package:flutter/material.dart';

class AdminSocial extends StatelessWidget {
  const AdminSocial({super.key});

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
            'ADMIN',
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.w700),
          )
        ],
      ),
    );
  }
}