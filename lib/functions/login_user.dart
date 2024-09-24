import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String apiUrl = 'https://gentle-retreat-85040-e271e09ef439.herokuapp.com/api/users';

  Future<Map<String, String?>?> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$apiUrl/login'),
      headers: {
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      
      
      return {
        'token': data['token'],
        'email': data['email'],
        'type': data['type'],
      };
    } else {
      
      return null;
    }
  }
}
