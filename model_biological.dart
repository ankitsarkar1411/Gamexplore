class Biological {
  final String title;
  final String description;
  final String sport;
  final String link;
  final String videoLink;
  Biological(
      {required this.title,
      required this.description,
      required this.sport,
      required this.link,
      required this.videoLink});
  factory Biological.fromFirestore(Map<String, dynamic> data) {
    return Biological(
        sport: data['sport'],
        title: data['title'],
        description: data['description'],
        link: data['link'],
        videoLink: data['video_title']);
  }
  Map<String, dynamic> toFirestore() {
    return {
      'sport': sport,
      'title': title,
      'description': description,
      'videoLink': videoLink,
      'link': link
    };
  }
}
