import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String apiUrl = 'http://10.169.28.210:5000/api/users';

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
      print(data);
      // print("tokens????");
      return {
        'token': data['token'],
        'email': data['email'],
        'type': data['type'],
      };
    } else {
      print("didnt get tokens");
      return null;
    }
  }
}
