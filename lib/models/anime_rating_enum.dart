enum AnimeRating { g, pg, pg13, r17, r }

extension AnimeRatingExtension on AnimeRating {
  String get toQueryString {
    return name;
  }

  String get label {
    switch (this) {
      case AnimeRating.g:
        return "G - All Ages";
      case AnimeRating.pg:
        return "PG - Children";
      case AnimeRating.pg13:
        return "PG-13 - Teens 13 or older";
      case AnimeRating.r17:
        return " R - 17+ (violence & profanity)";
      case AnimeRating.r:
        return "R+ - Mild Nudity";
    }
  }
}
