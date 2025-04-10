class QuizQuestion {
  final String question;
  final String option_1;
  final String option_2;
  final String option_3;
  final String option_4;
  final String answer;
  final String sport;
  QuizQuestion(
      {required this.question,
      required this.answer,
      required this.option_1,
      required this.option_2,
      required this.option_3,
      required this.option_4,
      required this.sport});

  factory QuizQuestion.fromFirestore(Map<String, dynamic> data) {
    return QuizQuestion(
        sport: data['sport'],
        question: data['question'],
        answer: data['answer'],
        option_1: data['option_1'],
        option_2: data['option_2'],
        option_3: data['option_3'],
        option_4: data['option_4']);
  }
  Map<String, dynamic> toFirestore() {
    return {
      'sport': sport,
      'question': question,
      'answer': answer,
      'option_1': option_1,
      'option_2': option_2,
      'option_3': option_3,
      'option_4': option_4
    };
  }
}
