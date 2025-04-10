import 'package:flutter/material.dart';
import 'package:gamexplore/common_injuries.dart';
import 'package:gamexplore/sport_injuries.dart';

class InjuriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Injuries'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildInjuryCard(context, 'Common Injuries', CommonInjuriesPage()),
            SizedBox(height: 16),
            _buildInjuryCard(context, 'Sport-Specific Injuries',
                SportSpecificInjuriesPage()),
          ],
        ),
      ),
    );
  }

  // Helper method to create injury cards
  Widget _buildInjuryCard(BuildContext context, String title, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(Icons.healing, size: 40, color: Colors.green),
              SizedBox(width: 20),
              Text(
                title,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
