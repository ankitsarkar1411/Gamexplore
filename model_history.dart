class History {
  final String sport;
  final String decade;
  final String description;

  History(
      {required this.sport, required this.decade, required this.description});

  factory History.fromFirestore(Map<String, dynamic> data) {
    return History(
        sport: data['sport'],
        decade: data['decade'],
        description: data['description']);
  }
  Map<String, dynamic> toFirestore() {
    return {'sport': sport, 'decade': decade, 'description': description};
  }
}
