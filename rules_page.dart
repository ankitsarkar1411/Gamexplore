import 'package:flutter/material.dart';
import 'package:gamexplore/rules_detail.dart';
import 'package:gamexplore/tactic_detail.dart';

class RulesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rules & Tactics'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildRulesCard(context, 'Rules', RulesDetailPage()),
            SizedBox(height: 16),
            _buildRulesCard(context, 'Tactics', TacticsDetailPage()),
          ],
        ),
      ),
    );
  }

  // Helper method to create cards for rules and tactics
  Widget _buildRulesCard(BuildContext context, String title, Widget page) {
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
              Icon(Icons.rule, size: 40, color: Colors.green),
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
