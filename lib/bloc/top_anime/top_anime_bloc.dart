import 'package:anime_explore/models/anime.dart';
import 'package:anime_explore/models/paged_response.dart';
import 'package:anime_explore/services/jikan_service/jikan_service.dart';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'top_anime_event.dart';
part 'top_anime_state.dart';

class TopAnimeBloc extends Bloc<TopAnimeEvent, TopAnimeState> {
  TopAnimeBloc() : super(TopAnimeInitial()) {
    on<TopAnimeCall>(_onTopAnimeCalled);
  }

  /// Handles the [TopAnimeCall] event.
  ///
  /// Fetches the top anime from the Jikan API.
  Future<void> _onTopAnimeCalled(TopAnimeCall event, emit) async {
    emit(TopAnimeLoading());
    try {
      final animes = await JikanService().getTopAnime();
      emit(TopAnimeSuccess(animes));
    } catch (e) {
      emit(TopAnimeError(e.toString()));
    }
  }
}
