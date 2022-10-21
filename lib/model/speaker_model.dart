class Speaker {
  final String id;
  final String name;
  final String bio;
  final String topic;
  final String image;
  final String? twitter;
  final String? linkedin;
  final String? slideUrl;

  const Speaker({
    required this.id,
    required this.name,
    required this.bio,
    required this.topic,
    required this.image,
    this.twitter,
    this.linkedin,
    this.slideUrl,
  });
}
