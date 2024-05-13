part of 'anime_search_bloc.dart';

sealed class AnimeSearchEvent extends Equatable {
  const AnimeSearchEvent();

  @override
  List<Object> get props => [];
}

class AnimeSearchCall extends AnimeSearchEvent {
  final AnimeSearchArgs args;

  const AnimeSearchCall(this.args);

  @override
  List<Object> get props => [args];
}

class AnimeSearchNextPage extends AnimeSearchEvent {}
