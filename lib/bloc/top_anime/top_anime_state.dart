part of 'top_anime_bloc.dart';

sealed class TopAnimeState extends Equatable {
  const TopAnimeState();

  @override
  List<Object> get props => [];
}

final class TopAnimeInitial extends TopAnimeState {}

final class TopAnimeLoading extends TopAnimeState {}

final class TopAnimeSuccess extends TopAnimeState {
  final PagedResponse<Anime> animes;

  const TopAnimeSuccess(this.animes);

  @override
  List<Object> get props => [animes];
}

final class TopAnimeError extends TopAnimeState {
  final String message;

  const TopAnimeError(this.message);

  @override
  List<Object> get props => [message];
}
