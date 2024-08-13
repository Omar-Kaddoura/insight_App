import 'package:flutter/material.dart';
import 'package:insight/Pages/Authentication/login_page.dart';
import 'package:insight/Pages/Authentication/register_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: constraints.maxWidth * 0.05,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Logo Image
                    Image.asset(
                      'assets/logo.png',
                      width: constraints.maxWidth * 0.3,
                      height: constraints.maxHeight * 0.15,
                    ),
                    SizedBox(height: constraints.maxHeight * 0.02),
                    // Welcome Text
                    Text(
                      'Welcome to the\nInsight Club App',
                      style: TextStyle(
                        fontSize: constraints.maxHeight * 0.03,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: constraints.maxHeight * 0.02),
                    // Phone Image
                    Image.asset(
                      'assets/phone.png',
                      width: constraints.maxWidth * 0.4,
                      height: constraints.maxHeight * 0.25,
                    ),
                    SizedBox(height: constraints.maxHeight * 0.03),
                    // Sign Up Button
                    SizedBox(
                      width: constraints.maxWidth * 0.6,
                      height: constraints.maxHeight * 0.07,
                      child: ElevatedButton(
                        child: Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: constraints.maxHeight * 0.025,
                            color: Colors.white,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF0066CC),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => RegisterScreen()),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: constraints.maxHeight * 0.02),
                    // Already have an account? Text
                    Text(
                      "Already have an account?",
                      style: TextStyle(
                        fontSize: constraints.maxHeight * 0.02,
                        color: Colors.blue,
                      ),
                    ),
                    TextButton(
                      child: Text(
                        'Log in',
                        style: TextStyle(
                          fontSize: constraints.maxHeight * 0.02,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.blueGrey,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
