import 'package:anime_explore/models/anime.dart';
import 'package:anime_explore/models/anime_search_args.dart';
import 'package:anime_explore/models/paged_response.dart';
import 'package:anime_explore/services/interceptors/error_interceptor.dart';
import 'package:anime_explore/services/jikan_service/jikan_service.dart';
import 'package:anime_explore/utils/constants/string_constants.dart';
import 'package:dio/dio.dart';

class JikanServiceApi implements JikanService {
  final Dio _api = Dio(
    BaseOptions(
      baseUrl: StringConstants.baseUrl,
      connectTimeout: const Duration(seconds: 15),
      sendTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 30),
    ),
  )..interceptors.add(ErrorInterceptor());

  /// Fetches the anime search results from the Jikan API.
  @override
  Future<PagedResponse<Anime>> getAnimeSearch(AnimeSearchArgs args) async {
    final response = await _api.get(
      '/anime',
      queryParameters: args.toQueryParameters(),
    );

    final result = response.data as Map<String, dynamic>;
    final data = result['data'] as List;
    final pagination = result['pagination'] as Map<String, dynamic>;

    final animesOrNull = data.map((e) {
      try {
        return Anime.fromJson(e);
      } catch (_) {
        return null;
      }
    }).toList();

    final animes = animesOrNull.whereType<Anime>().toList();

    return PagedResponse.fromJson(animes, pagination);
  }

  /// Fetches the top anime from the Jikan API.
  @override
  Future<PagedResponse<Anime>> getTopAnime() async {
    final response = await _api.get('/top/anime');

    final result = response.data as Map<String, dynamic>;
    final data = result['data'] as List;
    final pagination = result['pagination'] as Map<String, dynamic>;

    final animesOrNull = data.map((e) {
      try {
        return Anime.fromJson(e);
      } catch (_) {
        return null;
      }
    }).toList();

    final animes = animesOrNull.whereType<Anime>().toList();

    return PagedResponse.fromJson(animes, pagination);
  }
}
