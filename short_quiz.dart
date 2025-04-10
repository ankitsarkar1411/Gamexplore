import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ShortQuizPage extends StatefulWidget {
  @override
  _ShortQuizPageState createState() => _ShortQuizPageState();
}

class _ShortQuizPageState extends State<ShortQuizPage> {
  List<Question> _questions = [];
  int _score = 0;
  int _currentQuestionIndex = 0;
  bool _isQuizCompleted = false;

  @override
  void initState() {
    super.initState();
    _fetchQuestions();
  }

  Future<void> _fetchQuestions() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('questions').get();

    setState(() {
      _questions = snapshot.docs
          .map((doc) => Question.fromDocument(doc))
          .toList()
        ..shuffle(); // Shuffle questions
    });
  }

  void _answerQuestion(String selectedAnswer) {
    if (selectedAnswer == _questions[_currentQuestionIndex].correctAnswer) {
      _score++;
    }

    if (_currentQuestionIndex < 4) {
      
      setState(() {
        _currentQuestionIndex++;
      });
    } else {
      setState(() {
        _isQuizCompleted = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isQuizCompleted) {
      return Scaffold(
        appBar: AppBar(title: Text('Quiz Completed')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Your Score: $_score/5'),
              Text(_getFeedback()),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Back to Home'),
              ),
            ],
          ),
        ),
      );
    }

    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: Text('Short Quiz')),
        body: Center(child: CircularProgressIndicator()),
      );
    }

    Question currentQuestion = _questions[_currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(title: Text('Short Quiz')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              currentQuestion.question,
              style: TextStyle(fontSize: 20),
            ),
            ...currentQuestion.answers.map((answer) {
              return ElevatedButton(
                onPressed: () => _answerQuestion(answer),
                child: Text(answer),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  String _getFeedback() {
    if (_score >= 4) return 'Excellent!';
    if (_score == 3) return 'Good Job!';
    return 'Better luck next time!';
  }
}

class Question {
  final String question;
  final List<String> answers;
  final String correctAnswer;

  Question(
      {required this.question,
      required this.answers,
      required this.correctAnswer});

  factory Question.fromDocument(DocumentSnapshot doc) {
    List<dynamic> answers = doc['answers'];
    return Question(
      question: doc['question'],
      answers: List<String>.from(answers),
      correctAnswer: doc['correct'],
    );
  }
}
