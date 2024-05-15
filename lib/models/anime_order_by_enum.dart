enum AnimeOrderBy {
  malId,
  title,
  startDate,
  endDate,
  episodes,
  score,
  scoredBy,
  rank,
  popularity,
  members,
  favorites
}

extension AnimeInfoExtension on AnimeOrderBy {
  String get toQueryString {
    switch (this) {
      case AnimeOrderBy.malId:
        return "mal_id";
      case AnimeOrderBy.startDate:
        return "start_date";
      case AnimeOrderBy.endDate:
        return "end_date";
      case AnimeOrderBy.scoredBy:
        return "scored_by";
      default:
        return name;
    }
  }

  String get label {
    switch (this) {
      case AnimeOrderBy.malId:
        return "ID";
      case AnimeOrderBy.title:
        return "Title";
      case AnimeOrderBy.startDate:
        return "Start Date";
      case AnimeOrderBy.endDate:
        return "End Date";
      case AnimeOrderBy.episodes:
        return "Episodes";
      case AnimeOrderBy.score:
        return "Score";
      case AnimeOrderBy.scoredBy:
        return "Scored By";
      case AnimeOrderBy.rank:
        return "Rank";
      case AnimeOrderBy.popularity:
        return "Popularity";
      case AnimeOrderBy.members:
        return "Members";
      case AnimeOrderBy.favorites:
        return "Favorites";
    }
  }
}
