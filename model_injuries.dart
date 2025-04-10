class Injury {
  final String title;
  final String description;
  final String sport;
  final String link;
  final String videoLink;
  Injury(
      {required this.title,
      required this.description,
      required this.sport,
      required this.link,
      required this.videoLink});
  factory Injury.fromFirestore(Map<String, dynamic> data) {
    return Injury(
        sport: data['sport'],
        title: data['title'],
        description: data['description'],
        link: data['link'],
        videoLink: data['videoLink']);
  }
  Map<String, dynamic> toFirestore() {
    return {
      'sport': sport,
      'title': title,
      'description': description,
      'link': link,
      'videoLink': videoLink
    };
  }
}
