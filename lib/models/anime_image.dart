class AnimeImage {
  final String type;
  final String imageUrl;
  final String smallImageUrl;
  final String largeImageUrl;

  AnimeImage({
    required this.type,
    required this.imageUrl,
    required this.smallImageUrl,
    required this.largeImageUrl,
  });

  factory AnimeImage.fromJson(String type, Map<String, dynamic> json) {
    return AnimeImage(
      type: type,
      imageUrl: json['image_url'],
      smallImageUrl: json['small_image_url'],
      largeImageUrl: json['large_image_url'],
    );
  }
}
