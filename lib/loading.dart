import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoadingScreen extends StatefulWidget {
  final String? token;
  final String? userType;
  final String? email;
  LoadingScreen({required this.token, required this.userType, required this.email});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}
class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    fetchDataAndNavigate();
  }
  Future<void> fetchDataAndNavigate() async {
    await Future.delayed(Duration(seconds: 2)); // Simulate loading
  
    // if (widget.userType == 'Admin') {
    //   Navigator.pushReplacementNamed(context, '/admin_home');
    // } else {`
    //   Navigator.pushReplacementNamed(context, '/student_home');
    // }
  }

// use Provider in order to be able to load the function in the loading  screen 
// or maybe it can be done without creating a loading screen
// add the news social events and the profile to the 'loading screen or i think i should creatre a provider for each function separate



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(), // Show a loading indicator
      ),
    );
  }
}
