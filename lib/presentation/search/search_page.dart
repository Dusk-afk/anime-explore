import 'package:anime_explore/bloc/anime_search/anime_search_bloc.dart';
import 'package:anime_explore/models/anime.dart';
import 'package:anime_explore/models/anime_search_args.dart';
import 'package:anime_explore/models/paged_response.dart';
import 'package:anime_explore/presentation/anime/anime_card.dart';
import 'package:anime_explore/presentation/anime/anime_card_shimmer.dart';
import 'package:anime_explore/utils/constants/colors.dart';
import 'package:anime_explore/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  DateTime _lastTyped = DateTime.now();
  DateTime _lastScrolled = DateTime.now();
  final _scrollController = ScrollController();
  final _focusNode = FocusNode();
  final _queryController = TextEditingController();

  late BuildContext context = context;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollControllerListener);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollControllerListener);
    _scrollController.dispose();
    _focusNode.dispose();
    _queryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AnimeSearchBloc(),
      child: Builder(
        builder: (context) {
          this.context = context;
          return Scaffold(
            appBar: AppBar(
              title: const Text(
                "Search",
                style: TextStyle(
                  fontFamily: "Manga",
                  fontSize: TSizes.fontSizeXxl,
                ),
              ),
            ),
            body: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: PlatformSearchBar(
                    focusNode: _focusNode,
                    controller: _queryController,
                    onChanged: (q) => _onSearch(context, q),
                    textStyle: const TextStyle(
                      color: TColors.white,
                    ),
                  ),
                ),
                Expanded(
                  child: _body(),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _body() {
    return BlocBuilder<AnimeSearchBloc, AnimeSearchState>(
      builder: (context, state) {
        if (state is AnimeSearchInitial) return const SizedBox();
        if (state is AnimeSearchLoading) return _loadingWidget();
        if (state is AnimeSearchError) return _errorWidget(state.message);
        if (state is AnimeSearchSuccess) return _successWidget(state.animes);
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

  Widget _errorWidget(String message) {
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
                final args = AnimeSearchArgs(query: _queryController.text);
                context.read<AnimeSearchBloc>().add(AnimeSearchCall(args));
              },
              child: const Text("Retry"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _successWidget(PagedResponse<Anime> animes) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView.builder(
        controller: _scrollController,
        itemCount: animes.data.length,
        itemBuilder: (context, index) {
          final anime = animes.data[index];
          if (index == animes.data.length - 1 && animes.hasNextPage) {
            return Column(
              children: [
                AnimeCard(anime),
                if (animes.hasNextPage) PlatformCircularProgressIndicator(),
              ],
            );
          }
          return AnimeCard(anime);
        },
      ),
    );
  }

  void _onSearch(BuildContext context, String query) async {
    const Duration typingDuration = Duration(milliseconds: 500);
    _lastTyped = DateTime.now();
    await Future.delayed(typingDuration);
    if (DateTime.now().difference(_lastTyped) >= typingDuration) {
      final args = AnimeSearchArgs(query: query);
      context.read<AnimeSearchBloc>().add(AnimeSearchCall(args));
    }
  }

  void _scrollControllerListener() async {
    _lastScrolled = DateTime.now();
    await Future.delayed(const Duration(milliseconds: 500));
    if (DateTime.now().difference(_lastScrolled) <
        const Duration(milliseconds: 500)) {
      return;
    }
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      context.read<AnimeSearchBloc>().add(AnimeSearchNextPage());
    }
  }
}
