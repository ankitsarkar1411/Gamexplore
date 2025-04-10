class Tactic {
  final String title;
  final String description;
  final String sport;
  Tactic({required this.title, required this.description, required this.sport});
  factory Tactic.fromFirestore(Map<String, dynamic> data) {
    return Tactic(
        sport: data['sport'],
        title: data['title'],
        description: data['description']);
  }
  Map<String, dynamic> toFirestore() {
    return {'sport': sport, 'title': title, 'description': description};
  }
}
