import 'package:flutter/material.dart';
import 'package:gamexplore/global.dart';
import 'package:gamexplore/register_page.dart';
import 'package:gamexplore/sports_detail.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.blueAccent,
    ),
  );
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(GameXploreApp());
}

class GameXploreApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GameXplore',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RegisterPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GameXplore'),
        backgroundColor: Colors.green,
      ),
      body: Container(
        color: Colors.blue,
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 16.0,
          mainAxisSpacing: 16.0,
          children: [
            SportCard(
              sport: 'Cricket',
              imagePath: 'assets/cricket.jpg',
            ),
            SportCard(
              sport: 'Football',
              imagePath: 'assets/football.jpg',
            ),
            SportCard(
              sport: 'Tennis',
              imagePath: 'assets/tennis.jpg',
            ),
          ],
        ),
      ),
    );
  }
}

class SportCard extends StatelessWidget {
  final String sport;
  final String imagePath;

  SportCard({required this.sport, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        global.sport_name = sport.toLowerCase();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SportDetailPage(sport: sport),
          ),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: ClipRRect(
                borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                sport,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
