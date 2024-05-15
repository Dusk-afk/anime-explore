import 'package:anime_explore/models/anime_image.dart';
import 'package:anime_explore/models/anime_entity.dart';
import 'package:anime_explore/models/anime_trailer.dart';

/// Represents an anime.
class Anime {
  final int malId;
  final String url;
  final AnimeImage image;
  final AnimeTrailer trailer;
  final String title;
  final String? titleEnglish;
  final String? titleJapanese;
  final String type;
  final int episodes;
  final String status;
  final String duration;
  final String? rating;
  final double? score;
  final int? scoredBy;
  final int? rank;
  final int popularity;
  final int members;
  final int favorites;
  final String? synopsis;
  final String? season;
  final int? year;
  final List<AnimeEntity> producers;
  final List<AnimeEntity> licensors;
  final List<AnimeEntity> studios;
  final List<AnimeEntity> genres;
  final List<AnimeEntity> explicitGenres;
  final List<AnimeEntity> themes;
  final List<AnimeEntity> demographics;

  Anime({
    required this.malId,
    required this.url,
    required this.image,
    required this.trailer,
    required this.title,
    required this.titleEnglish,
    required this.titleJapanese,
    required this.type,
    required this.episodes,
    required this.status,
    required this.duration,
    required this.rating,
    required this.score,
    required this.scoredBy,
    required this.rank,
    required this.popularity,
    required this.members,
    required this.favorites,
    required this.synopsis,
    required this.season,
    required this.year,
    required this.producers,
    required this.licensors,
    required this.studios,
    required this.genres,
    required this.explicitGenres,
    required this.themes,
    required this.demographics,
  });

  factory Anime.fromJson(Map<String, dynamic> json) {
    return Anime(
      malId: json['mal_id'],
      url: json['url'],
      image: AnimeImage.fromJson('jpg', json['images']["jpg"]),
      trailer: AnimeTrailer.fromJson(json['trailer']),
      title: json['title'],
      titleEnglish: json['title_english'],
      titleJapanese: json['title_japanese'],
      type: json['type'],
      episodes: json['episodes'],
      status: json['status'],
      duration: json['duration'],
      rating: json['rating'],
      score: json['score'],
      scoredBy: json['scored_by'],
      rank: json['rank'],
      popularity: json['popularity'],
      members: json['members'],
      favorites: json['favorites'],
      synopsis: json['synopsis'],
      season: json['season'],
      year: json['year'],
      producers: (json['producers'] as List)
          .map((producer) => AnimeEntity.fromJson(producer))
          .toList(),
      licensors: (json['licensors'] as List)
          .map((licensor) => AnimeEntity.fromJson(licensor))
          .toList(),
      studios: (json['studios'] as List)
          .map((studio) => AnimeEntity.fromJson(studio))
          .toList(),
      genres: (json['genres'] as List)
          .map((genre) => AnimeEntity.fromJson(genre))
          .toList(),
      explicitGenres: (json['explicit_genres'] as List)
          .map((explicitGenre) => AnimeEntity.fromJson(explicitGenre))
          .toList(),
      themes: (json['themes'] as List)
          .map((theme) => AnimeEntity.fromJson(theme))
          .toList(),
      demographics: (json['demographics'] as List)
          .map((demographic) => AnimeEntity.fromJson(demographic))
          .toList(),
    );
  }
}
