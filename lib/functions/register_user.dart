import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class RegisterUser {
  final String username;
  final String email;
  final String password;
  

  RegisterUser({required this.username, required this.email, required this.password});

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'email': email,
      'password': password,
    };
  }
}

Future<void> registerUser(RegisterUser user) async {
  const String url = 'https://gentle-retreat-85040-e271e09ef439.herokuapp.com/api/users/register'; // Update with your server's address

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode(user.toJson()),
    );

    if (response.statusCode == 201) {
      print('User registered successfully');
    } else {
      print('Failed to register user: ${response.body}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
