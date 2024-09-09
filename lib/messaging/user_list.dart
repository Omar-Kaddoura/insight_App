import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class UsersListScreen extends StatefulWidget {
  @override
  _UsersListScreenState createState() => _UsersListScreenState();
}

class _UsersListScreenState extends State<UsersListScreen> {
  final _storage = FlutterSecureStorage();
  List<dynamic> _users = [];
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    final email = await _storage.read(key: 'email');
    // print(email);
    if (email == null) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'User email is not available';
      });
      return;
    }


    String filter ='';
    final response = await http.get(
      Uri.parse('http://10.169.29.139:5000/api/users/usersByFilter?email=$email&$filter'),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      try {
        final data = jsonDecode(response.body);
        if (data is List) {
          setState(() {
            _users = data;
            _isLoading = false;
          });
        } else {
          setState(() {
            _isLoading = false;
            _errorMessage = 'Unexpected data format';
          });
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Error parsing JSON: $e';
        });
      }
    } else {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Failed to load users';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,  // Remove the back arrow
        flexibleSpace: FlexibleSpaceBar(
          centerTitle: true,
          title: Text(
            'Users List',
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _errorMessage.isNotEmpty
          ? Center(child: Text(_errorMessage, style: TextStyle(color: Colors.red)))
          : _users.isEmpty
          ? Center(child: Text('No users found'))
          : ListView.builder(
        itemCount: _users.length,
        itemBuilder: (context, index) {
          final user = _users[index];
          final email = user['email'] ?? 'Unknown Email';
          final type = user['type'] ?? 'Unknown Type';

          return ListTile(
            title: Text(email),
            subtitle: Text(type),
          );
        },
      ),
    );
  }
}
