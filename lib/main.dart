import 'package:flutter/material.dart';
import 'routes.dart'; // Import the routes file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gesturease', // Change the title to match your app name
      initialRoute: '/', // Set the initial route to the home screen
      routes: AppRoutes.getRoutes(), // Fetch the routes from routes.dart
    );
  }
}