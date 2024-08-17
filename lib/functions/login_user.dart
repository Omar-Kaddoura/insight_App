import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String apiUrl = 'http://192.168.0.124:5000/api/users';

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
      print("tokens????");
      return {
        'token': data['token'],
        'type': data['type'],
      };
    } else {
      print("didnt get tokens");
      return null;
    }
  }
}
