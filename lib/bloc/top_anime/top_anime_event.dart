part of 'top_anime_bloc.dart';

sealed class TopAnimeEvent extends Equatable {
  const TopAnimeEvent();

  @override
  List<Object> get props => [];
}

class TopAnimeCall extends TopAnimeEvent {}
