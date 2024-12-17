import 'dart:convert';
import 'package:http/http.dart' as http;
import '/models/tts_request.dart';

class TTSService {
  Future<void> sendTTSRequest(TTSRequest request) async {
    final response = await http.post(
      Uri.parse('https://example.com/tts'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      print('TTS Request successful');
    } else {
      throw Exception('Failed to process TTS request');
    }
  }
}
