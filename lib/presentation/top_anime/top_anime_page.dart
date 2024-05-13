import 'package:anime_explore/bloc/top_anime/top_anime_bloc.dart';
import 'package:anime_explore/models/anime.dart';
import 'package:anime_explore/models/paged_response.dart';
import 'package:anime_explore/presentation/anime/anime_card.dart';
import 'package:anime_explore/presentation/anime/anime_card_shimmer.dart';
import 'package:anime_explore/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TopAnimePage extends StatelessWidget {
  final VoidCallback onSearch;
  const TopAnimePage({super.key, required this.onSearch});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TopAnimeBloc()..add(TopAnimeCall()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Top Anime",
            style: TextStyle(
              fontFamily: "Manga",
              fontSize: TSizes.fontSizeXxl,
            ),
          ),
          actions: [
            IconButton(
              onPressed: onSearch,
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return BlocBuilder<TopAnimeBloc, TopAnimeState>(
      builder: (context, state) {
        if (state is TopAnimeInitial) return const SizedBox();
        if (state is TopAnimeLoading) return _loadingWidget();
        if (state is TopAnimeError) return _errorWidget(context, state.message);
        if (state is TopAnimeSuccess) return _successWidget(state.animes);
        return const SizedBox();
      },
    );
  }

  Widget _loadingWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) {
          return const AnimeCardShimmer();
        },
      ),
    );
  }

  Widget _errorWidget(BuildContext context, String message) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/alert.png",
              width: 100,
              height: 100,
            ),
            const SizedBox(height: 10),
            Text(message),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                context.read<TopAnimeBloc>().add(TopAnimeCall());
              },
              child: const Text("Retry"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _successWidget(PagedResponse<Anime> animes) {
    final animesSorted = animes.data
      ..sort((a, b) => a.rank!.compareTo(b.rank!));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView.builder(
        itemCount: animes.data.length,
        itemBuilder: (context, index) {
          final anime = animesSorted[index];
          return AnimeCard(anime, showRank: true);
        },
      ),
    );
  }
}
