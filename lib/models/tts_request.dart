class TTSRequest {
  final String text;
  final String voice;
  final String language;

  TTSRequest({required this.text, required this.voice, required this.language});

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'voice': voice,
      'language': language,
    };
  }
}
