class AnimeEntity {
  final int malId;
  final String type;
  final String name;
  final String url;

  AnimeEntity({
    required this.malId,
    required this.type,
    required this.name,
    required this.url,
  });

  factory AnimeEntity.fromJson(Map<String, dynamic> json) {
    return AnimeEntity(
      malId: json['mal_id'],
      type: json['type'],
      name: json['name'],
      url: json['url'],
    );
  }
}
