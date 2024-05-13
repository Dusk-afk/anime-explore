part of 'anime_search_bloc.dart';

sealed class AnimeSearchState extends Equatable {
  const AnimeSearchState();

  @override
  List<Object> get props => [];
}

final class AnimeSearchInitial extends AnimeSearchState {}

final class AnimeSearchLoading extends AnimeSearchState {}

final class AnimeSearchSuccess extends AnimeSearchState {
  final AnimeSearchArgs args;
  final PagedResponse<Anime> animes;
  final bool loadingNextPage;

  const AnimeSearchSuccess(this.args, this.animes,
      {this.loadingNextPage = false});

  @override
  List<Object> get props => [args, animes];

  AnimeSearchSuccess copyWith({
    AnimeSearchArgs? args,
    PagedResponse<Anime>? animes,
    bool? loadingNextPage,
  }) {
    return AnimeSearchSuccess(
      args ?? this.args,
      animes ?? this.animes,
      loadingNextPage: loadingNextPage ?? this.loadingNextPage,
    );
  }
}

final class AnimeSearchError extends AnimeSearchState {
  final AnimeSearchArgs args;
  final String message;

  const AnimeSearchError(this.args, this.message);

  @override
  List<Object> get props => [args, message];
}
