import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutISLScreen extends StatelessWidget {
  const AboutISLScreen({super.key});

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);

    // Attempt to launch the URL
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        throw 'Could not launch $url';
      }
    } catch (e) {
      print("Error launching URL: $e");
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About ISL'),
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Indian Sign Language (ISL)',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Indian Sign Language (ISL) is a rich and expressive visual language...',
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    _launchURL('https://en.wikipedia.org/wiki/Indian_Sign_Language');
                  },
                  child: const Text('Learn More on Wikipedia'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
