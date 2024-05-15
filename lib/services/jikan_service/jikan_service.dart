import 'package:anime_explore/models/anime.dart';
import 'package:anime_explore/models/anime_search_args.dart';
import 'package:anime_explore/models/paged_response.dart';
import 'package:anime_explore/services/jikan_service/jikan_service_api.dart';

abstract class JikanService {
  static final JikanService _instance = JikanServiceApi();
  factory JikanService() => _instance;

  Future<PagedResponse<Anime>> getAnimeSearch(AnimeSearchArgs args);
  Future<PagedResponse<Anime>> getTopAnime();
}
