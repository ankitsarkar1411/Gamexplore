class Pyschological {
  final String title;
  final String description;
  final String sport;
  Pyschological(
      {required this.title, required this.description, required this.sport});
  factory Pyschological.fromFirestore(Map<String, dynamic> data) {
    return Pyschological(
        sport: data['sport'],
        title: data['title'],
        description: data['description']);
  }
  Map<String, dynamic> toFirestore() {
    return {'sport': sport, 'title': title, 'description': description};
  }
}
