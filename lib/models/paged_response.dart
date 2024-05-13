class PagedResponse<T> {
  final List<T> data;
  final int lastVisiblePage;
  final bool hasNextPage;
  final int count;
  final int total;
  final int perPage;

  PagedResponse({
    required this.data,
    required this.lastVisiblePage,
    required this.hasNextPage,
    required this.count,
    required this.total,
    required this.perPage,
  });

  factory PagedResponse.fromJson(List<T> data, Map<String, dynamic> json) {
    return PagedResponse<T>(
      data: data,
      lastVisiblePage: json['last_visible_page'],
      hasNextPage: json['has_next_page'],
      count: json['items']['count'],
      total: json['items']['total'],
      perPage: json['items']['per_page'],
    );
  }

  operator +(PagedResponse<T> other) => PagedResponse(
        data: [...data, ...other.data],
        lastVisiblePage: other.lastVisiblePage,
        hasNextPage: other.hasNextPage,
        count: other.count,
        total: other.total,
        perPage: other.perPage,
      );
}
