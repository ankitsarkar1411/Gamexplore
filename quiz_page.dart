import 'package:flutter/material.dart';
import 'package:gamexplore/quiz_question.dart';

class QuizPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Page'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          // Makes the content scrollable
          child: Column(
            children: [
              Text(
                "Quiz Instructions:",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              GridView.count(
                crossAxisCount: 2, // Two cards per row
                childAspectRatio: 1.5, // Aspect ratio to fit cards properly
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                physics:
                    NeverScrollableScrollPhysics(), // Prevents nested scrolling
                shrinkWrap:
                    true, // Prevents GridView from taking infinite height
                children: [
                  _buildQuizTypeCard(
                    context,
                    'Rules for the Quiz:\n There will be 5 Questions\n Each Correct Answer will give +1 \n Each Wrong Answer will give -1 \n Click to continue',
                    Icons.timelapse,
                    QuizQuestionDetailPage(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to create cards for quiz types
  Widget _buildQuizTypeCard(
      BuildContext context, String title, IconData icon, Widget page) {
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
                  title,
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
