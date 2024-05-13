class AnimeTrailer {
  final String? youtubeId;
  final String? url;

  AnimeTrailer({
    required this.youtubeId,
    required this.url,
  });

  factory AnimeTrailer.fromJson(Map<String, dynamic> json) {
    return AnimeTrailer(
      youtubeId: json['youtube_id'],
      url: json['url'],
    );
  }
}
