/// PagedResponse is a generic class that represents a response from the API that contains a list of items.
///
/// It contains the following properties:
/// - [data] is the list of items.
/// - [lastVisiblePage] is the last visible page.
/// - [hasNextPage] is a boolean that indicates if there is a next page.
/// - [count] is the number of items in the current page.
/// - [total] is the total number of items.
/// - [perPage] is the number of items per page.
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

  /// Returns a new [PagedResponse] with the given [data].
  ///
  /// This method is useful when you want to update the data of the [PagedResponse].
  operator +(PagedResponse<T> other) => PagedResponse(
        data: [...data, ...other.data],
        lastVisiblePage: other.lastVisiblePage,
        hasNextPage: other.hasNextPage,
        count: other.count,
        total: other.total,
        perPage: other.perPage,
      );
}
