class Rule {
  final String title;
  final String description;
  final String sport;
  Rule({required this.title, required this.description, required this.sport});
  factory Rule.fromFirestore(Map<String, dynamic> data) {
    return Rule(
        sport: data['sport'],
        title: data['title'],
        description: data['description']);
  }
  Map<String, dynamic> toFirestore() {
    return {'sport': sport, 'title': title, 'description': description};
  }
}
