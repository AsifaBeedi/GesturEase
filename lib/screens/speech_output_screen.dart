import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_tts/flutter_tts.dart';

class SpeechOutputScreen extends StatefulWidget {
  const SpeechOutputScreen({super.key});

  @override
  _SpeechOutputScreenState createState() => _SpeechOutputScreenState();
}

class _SpeechOutputScreenState extends State<SpeechOutputScreen> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  final FlutterTts _flutterTts = FlutterTts();
  bool _isProcessing = false;
  String _recognizedGesture = '';

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    final cameras = await availableCameras();
    final firstCamera = cameras.first;

    _controller = CameraController(
      firstCamera,
      ResolutionPreset.medium,
    );

    _initializeControllerFuture = _controller.initialize();
  }

  Future<void> _processFrame() async {
    if (_isProcessing) return;
    _isProcessing = true;

    try {
      await _initializeControllerFuture; // Ensure the camera is initialized
      final image = await _controller.takePicture();
      final bytes = await image.readAsBytes();

      // Send the image to the backend for gesture recognition
      final response = await http.post(
        Uri.parse(
            'http://localhost:8000/predict/'), // Update with your backend URL
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'image': base64Encode(bytes)}),
      );

      if (response.statusCode == 200) {
        final prediction = jsonDecode(response.body)['predicted_class'];
        setState(() {
          _recognizedGesture = prediction;
        });
        _speak(prediction);
      } else {
        setState(() {
          _recognizedGesture = 'Error: ${response.reasonPhrase}';
        });
      }
    } catch (e) {
      setState(() {
        _recognizedGesture = 'Error: $e';
      });
    } finally {
      _isProcessing = false;
    }
  }

  Future<void> _speak(String text) async {
    await _flutterTts.speak(text);
  }

  @override
  void dispose() {
    _controller.dispose();
    _flutterTts.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Speech Output'),
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'This feature uses the camera to recognize sign language gestures and convert them to speech.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: FutureBuilder<void>(
                future: _initializeControllerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return CameraPreview(_controller);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _processFrame,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepPurple[600],
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              child: Text('Recognize Gesture'),
            ),
            SizedBox(height: 20),
            Text(
              _recognizedGesture.isNotEmpty
                  ? 'Recognized Gesture: $_recognizedGesture'
                  : 'No gesture recognized yet',
              style: TextStyle(fontSize: 20, color: Colors.white),
            ),
            SizedBox(height: 20),
            Text(
              'A new way to interact with sign language gestures.',
              style: TextStyle(
                fontSize: 16,
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
