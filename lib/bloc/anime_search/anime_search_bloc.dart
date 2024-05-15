import 'package:anime_explore/models/anime.dart';
import 'package:anime_explore/models/anime_search_args.dart';
import 'package:anime_explore/models/paged_response.dart';
import 'package:anime_explore/services/jikan_service/jikan_service.dart';
// ignore: depend_on_referenced_packages
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'anime_search_event.dart';
part 'anime_search_state.dart';

class AnimeSearchBloc extends Bloc<AnimeSearchEvent, AnimeSearchState> {
  AnimeSearchBloc() : super(AnimeSearchInitial()) {
    on<AnimeSearchCall>(_onAnimeSearchCalled);
    on<AnimeSearchNextPage>(_onAnimeSearchNextPage);
  }

  /// Handles the [AnimeSearchCall] event.
  ///
  /// Searches for anime based on the [AnimeSearchArgs] provided in the event.
  Future<void> _onAnimeSearchCalled(AnimeSearchCall event, emit) async {
    emit(AnimeSearchLoading());
    try {
      final animes = await JikanService().getAnimeSearch(event.args);
      emit(AnimeSearchSuccess(event.args, animes));
    } catch (e) {
      emit(AnimeSearchError(event.args, e.toString()));
    }
  }

  /// Handles the [AnimeSearchNextPage] event.
  ///
  /// Fetches the next page of anime search results.
  Future<void> _onAnimeSearchNextPage(AnimeSearchNextPage event, emit) async {
    final currState = state;
    if (currState is AnimeSearchSuccess) {
      if (currState.loadingNextPage) {
        return; // If already loading next page, do nothing
      }

      if (!currState.animes.hasNextPage) {
        return; // If there is no next page, do nothing
      }

      // Set loadingNextPage to true and emit the current state
      emit(currState.copyWith(loadingNextPage: true));

      // Modify the args and fetch the next page of anime search results
      final args = currState.args;
      final nextPage = args.copyWith(page: args.page + 1);
      final animes = await JikanService().getAnimeSearch(nextPage);
      final newState = currState.copyWith(
        args: nextPage,
        animes: currState.animes + animes,
        loadingNextPage: false,
      );
      emit(newState);
    }
  }
}
