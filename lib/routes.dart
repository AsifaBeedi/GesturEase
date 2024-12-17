import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/sign_recognition_screen.dart';
import 'screens/text_translation_screen.dart';
import 'screens/speech_output_screen.dart';
import 'screens/learning_resources_screen.dart';
import 'screens/about_isl_screen.dart';

class AppRoutes {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      '/': (context) => const HomeScreen(),
      '/sign_recognition': (context) => SignRecognitionScreen(
            onGestureRecognized: (gesture) {
              // Handle the recognized gesture here or pass it to a global handler
              print('Recognized Gesture: $gesture');
            },
          ),
      '/text_translation': (context) => const TextTranslationScreen(),
      '/speech_output': (context) => const SpeechOutputScreen(),
      '/learning_resources': (context) => const LearningResourcesScreen(),
      '/about_isl_screen': (context) => const AboutISLScreen(),
    };
  }
}
