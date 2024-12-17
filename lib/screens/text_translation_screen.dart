import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'sign_recognition_screen.dart'; // Import the SignRecognitionScreen

class TextTranslationScreen extends StatefulWidget {
  const TextTranslationScreen({super.key});

  @override
  _TextTranslationScreenState createState() => _TextTranslationScreenState();
}

class _TextTranslationScreenState extends State<TextTranslationScreen> {
  final TextEditingController _controller = TextEditingController();
  String _translatedText = '';
  String _recognizedGesture = ''; // Placeholder for recognized gesture text
  String _selectedLanguage = 'es'; // Default language is Spanish

  // Function to translate text
  Future<void> _translateText(String text) async {
    final translator = GoogleTranslator();
    var translation = await translator.translate(text, to: _selectedLanguage);
    setState(() {
      _translatedText = translation.text;
    });
  }

  // Function to handle recognized gesture
  void _handleRecognizedGesture(String gestureText) {
    setState(() {
      _recognizedGesture = gestureText;
    });
    _translateText(gestureText);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text Translation'),
        backgroundColor: Colors.deepPurple[800],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple[900]!, Colors.black],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Enter text to translate',
                hintStyle: TextStyle(color: Colors.white54),
                filled: true,
                fillColor: Colors.deepPurple[700],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: _selectedLanguage,
              dropdownColor: Colors.deepPurple[700],
              onChanged: (String? newValue) {
                setState(() {
                  _selectedLanguage = newValue!;
                });
              },
              items: <String>['es', 'fr', 'de', 'zh', 'hi', 'kn', 'ta']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    _getLanguageName(value),
                    style: TextStyle(color: Colors.white),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _translateText(_controller.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple[600],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text('Translate'),
            ),
            SizedBox(height: 20),
            Text(
              'Recognized Gesture: $_recognizedGesture',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'Translated Text: $_translatedText',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(height: 20),
            Expanded(
              child: SignRecognitionScreen(
                onGestureRecognized: _handleRecognizedGesture,
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getLanguageName(String code) {
    switch (code) {
      case 'es':
        return 'Spanish';
      case 'fr':
        return 'French';
      case 'de':
        return 'German';
      case 'zh':
        return 'Chinese';
      case 'hi':
        return 'Hindi';
      case 'kn':
        return 'Kannada';
      case 'ta':
        return 'Tamil';
      default:
        return 'Unknown';
    }
  }
}
