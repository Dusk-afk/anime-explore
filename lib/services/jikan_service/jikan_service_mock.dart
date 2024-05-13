import 'package:anime_explore/models/anime.dart';
import 'package:anime_explore/models/anime_search_args.dart';
import 'package:anime_explore/models/paged_response.dart';
import 'package:anime_explore/services/jikan_service/jikan_service.dart';

class JikanServiceMock implements JikanService {
  @override
  Future<PagedResponse<Anime>> getAnimeSearch(AnimeSearchArgs args) async {
    await Future.delayed(const Duration(seconds: 2));
    throw UnimplementedError();
  }

  @override
  Future<PagedResponse<Anime>> getTopAnime() async {
    throw UnimplementedError();
  }
}
