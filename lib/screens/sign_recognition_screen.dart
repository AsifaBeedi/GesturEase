import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:typed_data';
import 'package:image/image.dart' as img;

class SignRecognitionScreen extends StatefulWidget {
  final Function(String) onGestureRecognized;

  const SignRecognitionScreen({super.key, required this.onGestureRecognized});

  @override
  _SignRecognitionScreenState createState() => _SignRecognitionScreenState();
}

class _SignRecognitionScreenState extends State<SignRecognitionScreen> {
  final ImagePicker _picker = ImagePicker();
  String _prediction = '';
  bool _isLoading = false;

  // Function to pick an image and send it to the backend
  Future<void> _pickAndSendImage() async {
    setState(() {
      _isLoading = true; // Show loading indicator
    });

    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final bytes = await pickedFile.readAsBytes();

      // Resize the image
      img.Image? image = img.decodeImage(bytes);
      img.Image resizedImage = img.copyResize(image!, width: 224, height: 224);

      // Convert the resized image to bytes
      Uint8List resizedBytes = Uint8List.fromList(img.encodeJpg(resizedImage));

      final response = await http.post(
        Uri.parse(
            'http://localhost:8000/predict/'), // Update with your backend URL
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'image': base64Encode(resizedBytes)}),
      );

      if (response.statusCode == 200) {
        setState(() {
          _prediction = jsonDecode(response.body)['predicted_class'];
          _isLoading = false; // Hide loading indicator
        });
        widget.onGestureRecognized(_prediction);
      } else {
        setState(() {
          _prediction = 'Error: ${response.reasonPhrase}';
          _isLoading = false; // Hide loading indicator
        });
      }
    } else {
      setState(() {
        _isLoading = false; // Hide loading indicator
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Recognition'),
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
            Text(
              'Recognize Sign Language',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Upload an image to recognize the sign language gesture. '
              'This tool helps you learn and understand Indian Sign Language.',
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            _isLoading
                ? CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )
                : _prediction.isNotEmpty
                    ? Text(
                        'Prediction: $_prediction',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      )
                    : Text(
                        'No prediction yet',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickAndSendImage,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple[600],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text('Pick and Send Image'),
            ),
            SizedBox(height: 20),
            Text(
              '“The only limit to our realization of tomorrow is our doubts of today.”\n'
              '– Franklin D. Roosevelt',
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              '“Believe you can and you\'re halfway there.”\n'
              '– Theodore Roosevelt',
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: Colors.white70,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
