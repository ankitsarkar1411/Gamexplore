import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gamexplore/global.dart';
import 'model_quiz.dart';

class QuizQuestionDetailPage extends StatefulWidget {
  @override
  _QuizQuestionDetailState createState() => _QuizQuestionDetailState();
}

class _QuizQuestionDetailState extends State<QuizQuestionDetailPage> {
  int score = 0;
  int currentQuestionIndex = 0;
  List<QuizQuestion> shuffledQuestions = [];

  // Fetch and shuffle questions once
  Future<void> fetchQuestions() async {
    try {
      var querySnapshot = await FirebaseFirestore.instance
          .collection('/questions')
          .where('sport', isEqualTo: global.sport_name)
          .get();

      setState(() {
        shuffledQuestions = querySnapshot.docs.map((doc) {
          return QuizQuestion(
            sport: doc['sport'] ?? 'Unknown Sport',
            question: doc['question'] ?? 'Untitled',
            option_1: doc['option_1'] ?? 'NA',
            option_2: doc['option_2'] ?? 'NA',
            option_3: doc['option_3'] ?? 'NA',
            option_4: doc['option_4'] ?? 'NA',
            answer: doc['answer'] ?? 'NA',
          );
        }).toList()
          ..shuffle();
      });
    } catch (e) {
      debugPrint("Error fetching questions: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchQuestions();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Quiz for ${global.sport_name.toUpperCase()}\nYour Score = $score',
        ),
        backgroundColor: Colors.green,
      ),
      body: shuffledQuestions.isEmpty
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Rules Section
                  Container(
                    height: 100,
                    child: SingleChildScrollView(
                      child: Text(
                        "Rules: Select the correct answer. Each correct answer gives +1 point, and wrong answers deduct 1 point.",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  // Display Question
                  if (currentQuestionIndex < shuffledQuestions.length)
                    Expanded(
                      child: Card(
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                shuffledQuestions[currentQuestionIndex]
                                    .question,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 16),
                              ...[
                                shuffledQuestions[currentQuestionIndex]
                                    .option_1,
                                shuffledQuestions[currentQuestionIndex]
                                    .option_2,
                                shuffledQuestions[currentQuestionIndex]
                                    .option_3,
                                shuffledQuestions[currentQuestionIndex]
                                    .option_4,
                              ].map(
                                (option) => Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: ElevatedButton(
                                    onPressed: () {
                                      if (option ==
                                          shuffledQuestions[
                                                  currentQuestionIndex]
                                              .answer) {
                                        score++;
                                      } else {
                                        score--;
                                      }
                                      if (currentQuestionIndex + 1 <
                                          shuffledQuestions.length) {
                                        setState(() {
                                          currentQuestionIndex++;
                                        });
                                      } else {
                                        // End of quiz
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                "Quiz Completed! Your Score: $score"),
                                          ),
                                        );
                                      }
                                    },
                                    child: Text(option),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
    );
  }
}
