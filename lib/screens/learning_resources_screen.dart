import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LearningResourcesScreen extends StatelessWidget {
  const LearningResourcesScreen({super.key});

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Learning Resources'),
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
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            _buildResourceTile(
              title: 'Learn Indian Sign Language',
              subtitle: 'Watch YouTube videos to learn Indian Sign Language',
              url:
                  'https://www.youtube.com/results?search_query=learn+indian+sign+language',
            ),
            _buildResourceTile(
              title: 'Online ISL Courses',
              subtitle: 'Take online courses to improve your ISL skills',
              url: 'https://www.udemy.com/course/learn-indian-sign-language/',
            ),
            _buildResourceTile(
              title: 'ISL Dictionary',
              subtitle: 'Access an online dictionary for Indian Sign Language',
              url: 'https://indiansignlanguage.org/',
            ),
            _buildResourceTile(
              title: 'ISL Learning App',
              subtitle:
                  'Download an app to learn Indian Sign Language on the go',
              url:
                  'https://play.google.com/store/apps/details?id=com.signlearn',
            ),
            _buildResourceTile(
              title: 'ISL Community',
              subtitle: 'Join a community of ISL learners and practitioners',
              url: 'https://www.facebook.com/groups/indian.sign.language/',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResourceTile(
      {required String title, required String subtitle, required String url}) {
    return Card(
      color: Colors.deepPurple[700],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(color: Colors.white70),
        ),
        trailing: Icon(Icons.arrow_forward, color: Colors.white),
        onTap: () {
          _launchURL(url);
        },
      ),
    );
  }
}
