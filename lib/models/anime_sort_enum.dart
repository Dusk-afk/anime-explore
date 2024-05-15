enum AnimeSort { desc, asc }

extension AnimeSortExtension on AnimeSort {
  String get toQueryString => name;

  String get label => "${name[0].toUpperCase()}${name.substring(1)}";
}
