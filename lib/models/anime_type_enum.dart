enum AnimeType { tv, movie, ova, special, ona, music, cm, pv, tvSpecial }

extension AnimeTypeExtension on AnimeType {
  String? get toQueryString {
    if (this == AnimeType.tvSpecial) {
      return "tv_special";
    }
    return name;
  }

  String get label {
    switch (this) {
      case AnimeType.tv:
        return "TV";
      case AnimeType.movie:
        return "Movie";
      case AnimeType.ova:
        return "Ova";
      case AnimeType.special:
        return "Special";
      case AnimeType.ona:
        return "Ona";
      case AnimeType.music:
        return "Music";
      case AnimeType.cm:
        return "CM";
      case AnimeType.pv:
        return "PV";
      case AnimeType.tvSpecial:
        return "TV Special";
    }
  }
}
