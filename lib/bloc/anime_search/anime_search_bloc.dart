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

  Future<void> _onAnimeSearchCalled(AnimeSearchCall event, emit) async {
    emit(AnimeSearchLoading());
    try {
      final animes = await JikanService().getAnimeSearch(event.args);
      emit(AnimeSearchSuccess(event.args, animes));
    } catch (e) {
      emit(AnimeSearchError(event.args, e.toString()));
    }
  }

  Future<void> _onAnimeSearchNextPage(AnimeSearchNextPage event, emit) async {
    final currState = state;
    if (currState is AnimeSearchSuccess) {
      if (currState.loadingNextPage) return;
      emit(currState.copyWith(loadingNextPage: true));
      if (!currState.animes.hasNextPage) return;
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
