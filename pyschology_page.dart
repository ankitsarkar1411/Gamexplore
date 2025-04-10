import 'package:flutter/material.dart';
import 'package:gamexplore/biological_detail.dart';
import 'package:gamexplore/pyschological_detail.dart';

class PsychologyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Psychological & Biological Aspects'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildAspectCard(
                context, 'Psychological Aspects', PsychologicalDetailPage()),
            SizedBox(height: 16),
            _buildAspectCard(context, 'Biological Aspects', BiologicalPage()),
          ],
        ),
      ),
    );
  }

  Widget _buildAspectCard(BuildContext context, String title, Widget page) {
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
              Icon(Icons.psychology, size: 40, color: Colors.green),
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
