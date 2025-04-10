import 'package:flutter/material.dart';
import 'package:gamexplore/common_injuries.dart';
import 'package:gamexplore/pyschology_page.dart';
import 'history_page.dart'; // Make sure this page is implemented correctly
import 'quiz_page.dart'; // Make sure this page is implemented correctly
import 'rules_page.dart'; // Make sure this page is implemented correctly

class SportDetailPage extends StatelessWidget {
  final String sport;

  SportDetailPage({required this.sport});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$sport Details'),
        backgroundColor: Colors.green,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Two cards per row
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
            childAspectRatio: 1.5, // Adjust ratio for card fitting
          ),
          itemCount: _aspects.length,
          itemBuilder: (context, index) {
            final aspect = _aspects[index];
            return _buildAspectCard(
                context, aspect['title'], aspect['icon'], aspect['page']);
          },
        ),
      ),
    );
  }

  // Helper method to create aspect cards
  Widget _buildAspectCard(
      BuildContext context, String aspect, IconData icon, Widget page) {
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
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 40, color: Colors.green),
                SizedBox(height: 10),
                Text(
                  aspect,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// List of aspects to display, with corresponding pages and icons
final List<Map<String, dynamic>> _aspects = [
  {'title': 'History', 'icon': Icons.history, 'page': HistoryPage()},
  {'title': 'Rules & Tactics', 'icon': Icons.rule, 'page': RulesPage()},
  {
    'title': 'Different Aspects',
    'icon': Icons.psychology,
    'page': PsychologyPage()
  },
  {'title': 'Injuries', 'icon': Icons.healing, 'page': CommonInjuriesPage()},
  {'title': 'Quiz', 'icon': Icons.quiz, 'page': QuizPage()},
];
