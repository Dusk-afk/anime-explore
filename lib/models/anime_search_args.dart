import 'package:anime_explore/models/anime_order_by_enum.dart';
import 'package:anime_explore/models/anime_rating_enum.dart';
import 'package:anime_explore/models/anime_sort_enum.dart';
import 'package:anime_explore/models/anime_type_enum.dart';
import 'package:anime_explore/models/wrappeed.dart';

/// Arguments for searching anime.
///
/// [query] is the search query.
/// [page] is the page number.
/// [perPage] is the number of items per page.
/// [type] is the type of anime.
/// [rating] is the rating of anime.
/// [orderBy] is the order by field.
/// [sort] is the sort field.
class AnimeSearchArgs {
  final String query;
  final int page;
  final int perPage;
  final AnimeType? type;
  final AnimeRating? rating;
  final AnimeOrderBy? orderBy;
  final AnimeSort? sort;

  AnimeSearchArgs({
    required this.query,
    this.page = 1,
    this.perPage = 10,
    this.type,
    this.rating,
    this.orderBy,
    this.sort,
  });

  Map<String, Object?> toQueryParameters() => {
        'q': query,
        'page': page,
        'per_page': perPage,
        if (type != null) 'type': type!.toQueryString,
        if (rating != null) 'rating': rating!.toQueryString,
        if (orderBy != null) 'order_by': orderBy!.toQueryString,
        if (sort != null) 'sort': sort!.toQueryString,
      };

  AnimeSearchArgs copyWith({
    String? query,
    int? page,
    int? perPage,
    Wrapped<AnimeType?>? type,
    Wrapped<AnimeRating?>? rating,
    Wrapped<AnimeOrderBy?>? orderBy,
    Wrapped<AnimeSort?>? sort,
  }) {
    return AnimeSearchArgs(
      query: query ?? this.query,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      type: type != null ? type.value : this.type,
      rating: rating != null ? rating.value : this.rating,
      orderBy: orderBy != null ? orderBy.value : this.orderBy,
      sort: sort != null ? sort.value : this.sort,
    );
  }
}
