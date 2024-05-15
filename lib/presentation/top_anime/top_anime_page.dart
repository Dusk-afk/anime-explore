import 'dart:ui';

import 'package:anime_explore/bloc/top_anime/top_anime_bloc.dart';
import 'package:anime_explore/models/anime.dart';
import 'package:anime_explore/models/paged_response.dart';
import 'package:anime_explore/presentation/anime/anime_card.dart';
import 'package:anime_explore/presentation/anime/anime_card_shimmer.dart';
import 'package:anime_explore/utils/constants/colors.dart';
import 'package:anime_explore/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class TopAnimePage extends StatefulWidget {
  const TopAnimePage({super.key});

  @override
  State<TopAnimePage> createState() => _TopAnimePageState();
}

class _TopAnimePageState extends State<TopAnimePage>
    with AutomaticKeepAliveClientMixin {
  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider(
      create: (context) => TopAnimeBloc()..add(TopAnimeCall()),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 56),
          child: ClipRRect(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
              child: AppBar(
                backgroundColor: TColors.darkBlack.withOpacity(0.4),
                title: const Text(
                  "Top Anime",
                  style: TextStyle(
                    fontFamily: "Manga",
                    fontSize: TSizes.fontSizeXxl,
                  ),
                ),
              ),
            ),
          ),
        ),
        extendBodyBehindAppBar: true,
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
          if (index == 0) {
            return Container(
              margin: const EdgeInsets.only(top: 22),
              child: const AnimeCardShimmer(),
            );
          }
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
            PlatformElevatedButton(
              onPressed: () {
                context.read<TopAnimeBloc>().add(TopAnimeCall());
              },
              color: Theme.of(context).primaryColor,
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
      child: ListView.builder(
        itemCount: animes.data.length,
        itemBuilder: (context, index) {
          final anime = animesSorted[index];
          if (index == 0) {
            return Container(
              margin: const EdgeInsets.only(top: 22),
              child: AnimeCard(anime, showRank: true),
            );
          }
          return AnimeCard(anime, showRank: true);
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
