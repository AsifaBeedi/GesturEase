import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Home',
          style: TextStyle(color: Color(0xFFF5F5F5)), // Whitesmoke for text
        ),
        backgroundColor: Colors.black, // App bar background color
        iconTheme: const IconThemeData(color: Color(0xFFF5F5F5)), // Icon color
      ),
      body: Container(
        color: Colors.black, // Background color
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image section
              Image.asset(
                'assets/images/home_image.jpg',
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 20),
              // Button section
              _buildCustomButton(
                context,
                '/sign_recognition',
                'Sign Recognition',
              ),
              _buildCustomButton(
                context,
                '/text_translation',
                'Text Translation',
              ),
              _buildCustomButton(
                context,
                '/speech_output',
                'Speech Output',
              ),
              _buildCustomButton(
                context,
                '/learning_resources',
                'Learning Resources',
              ),
              _buildCustomButton(
                context,
                '/about_isl_screen',
                'About',
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Custom button widget with white borders
  Widget _buildCustomButton(BuildContext context, String route, String label) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.black, // Button background color
          foregroundColor: const Color(0xFFF5F5F5), // Button text color
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10), // Rounded button corners
            side:
                const BorderSide(color: Colors.white, width: 2), // White border
          ),
        ),
        onPressed: () => Navigator.pushNamed(context, route),
        child: Text(label),
      ),
    );
  }
}
