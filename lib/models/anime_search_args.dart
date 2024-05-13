class AnimeSearchArgs {
  final String query;
  final int page;
  final int perPage;

  AnimeSearchArgs({
    required this.query,
    this.page = 1,
    this.perPage = 10,
  });

  Map<String, Object?> toQueryParameters() => {
        'q': query,
        'page': page,
        'per_page': perPage,
      };

  AnimeSearchArgs copyWith({
    String? query,
    int? page,
    int? perPage,
  }) {
    return AnimeSearchArgs(
      query: query ?? this.query,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
    );
  }
}
