import 'package:flutter/material.dart';

class SportSpecificInjuriesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sport-Specific Injuries'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Add detailed content for sport-specific injuries
            Text(
              'Sport-specific injuries vary by the demands of each sport, such as tennis elbow, ACL tears in football, etc.',
              style: TextStyle(fontSize: 16),
            ),
            // Additional content can be added here
          ],
        ),
      ),
    );
  }
}
