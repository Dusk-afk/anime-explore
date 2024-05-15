import 'dart:ui';

import 'package:anime_explore/bloc/anime_search/anime_search_bloc.dart';
import 'package:anime_explore/models/anime.dart';
import 'package:anime_explore/models/anime_search_args.dart';
import 'package:anime_explore/models/paged_response.dart';
import 'package:anime_explore/presentation/anime/anime_card.dart';
import 'package:anime_explore/presentation/anime/anime_card_shimmer.dart';
import 'package:anime_explore/presentation/search/filter_search_dialog.dart';
import 'package:anime_explore/presentation/widgets/custom_search_bar.dart';
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

class _SearchPageState extends State<SearchPage>
    with AutomaticKeepAliveClientMixin {
  DateTime _lastTyped = DateTime.now();
  DateTime _lastScrolled = DateTime.now();
  final _scrollController = ScrollController();
  final _focusNode = FocusNode();
  final _queryController = TextEditingController();
  AnimeSearchArgs _args = AnimeSearchArgs(query: '');
  late final String _suggestion = _getAnimeSuggestion();

  late BuildContext innerContext = context;

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
    super.build(context);

    return BlocProvider(
      create: (context) => AnimeSearchBloc(),
      child: Builder(
        builder: (context) {
          innerContext = context;
          return GestureDetector(
            onTap: () {
              _focusNode.unfocus();
            },
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size(MediaQuery.of(context).size.width, 110),
                child: ClipRRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: AppBar(
                      backgroundColor: TColors.darkBlack.withOpacity(0.8),
                      title: const Text(
                        "Search",
                        style: TextStyle(
                          fontFamily: "Manga",
                          fontSize: TSizes.fontSizeXxl,
                        ),
                      ),
                      bottom: PreferredSize(
                        preferredSize:
                            Size(MediaQuery.of(context).size.width, 56),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: CustomSearchBar(
                                  focusNode: _focusNode,
                                  controller: _queryController,
                                  onChanged: (q) => _onSearch(context, q),
                                  hintText: "Search",
                                ),
                              ),
                              const SizedBox(width: 8),
                              PlatformIconButton(
                                onPressed: _onFilterPressed,
                                icon: const Icon(
                                  Icons.filter_list,
                                  color: TColors.white,
                                ),
                              )
                            ],
                          ),
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
        },
      ),
    );
  }

  Widget _body() {
    return BlocBuilder<AnimeSearchBloc, AnimeSearchState>(
      builder: (context, state) {
        if (state is AnimeSearchInitial) return _initialWidget();
        if (state is AnimeSearchLoading) return _loadingWidget();
        if (state is AnimeSearchError) return _errorWidget(state.message);
        if (state is AnimeSearchSuccess) return _successWidget(state.animes);
        return const SizedBox();
      },
    );
  }

  Widget _initialWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 100),
      child: Center(
        child: Text(
          'Try "$_suggestion"',
          style: const TextStyle(
            color: TColors.darkGrey,
            fontSize: TSizes.fontSizeLg,
          ),
        ),
      ),
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
            PlatformElevatedButton(
              onPressed: () {
                final args = AnimeSearchArgs(query: _queryController.text);
                innerContext.read<AnimeSearchBloc>().add(AnimeSearchCall(args));
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
    if (animes.data.isEmpty) {
      return const Padding(
        padding: EdgeInsets.only(top: 100),
        child: Center(
          child: Text(
            "No results found",
            style: TextStyle(
              color: TColors.white,
              fontSize: TSizes.fontSizeLg,
            ),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
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
                const SizedBox(height: 20),
              ],
            );
          }
          return AnimeCard(anime);
        },
      ),
    );
  }

  String _getAnimeSuggestion() {
    List<String> suggestions = [
      "Attack on Titan",
      "One Piece",
      "Naruto",
      "Death Note",
      "My Hero Academia",
      "Demon Slayer",
      "Tokyo Revengers",
      "Jujutsu Kaisen",
      "Dragon Ball",
      "Black Clover",
      "Bleach"
    ];

    return suggestions[DateTime.now().second % suggestions.length];
  }

  void _onFilterPressed() async {
    final AnimeSearchArgs? args = await showDialog(
      context: context,
      builder: (context) => FilterSearchDialog(args: _args),
    );
    if (args != null) {
      _args = args;
      _search();
    }
  }

  void _onSearch(BuildContext context, String query) async {
    const Duration typingDuration = Duration(milliseconds: 500);
    _lastTyped = DateTime.now();
    await Future.delayed(typingDuration);
    if (DateTime.now().difference(_lastTyped) >= typingDuration) {
      _args = _args.copyWith(query: query);
      _search();
    }
  }

  void _search() {
    innerContext.read<AnimeSearchBloc>().add(AnimeSearchCall(_args));
  }

  void _scrollControllerListener() async {
    FocusScope.of(context).unfocus();
    _lastScrolled = DateTime.now();
    await Future.delayed(const Duration(milliseconds: 500));
    if (DateTime.now().difference(_lastScrolled) <
        const Duration(milliseconds: 500)) {
      return;
    }
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.9) {
      // ignore: use_build_context_synchronously
      innerContext.read<AnimeSearchBloc>().add(AnimeSearchNextPage());
    }
  }

  @override
  bool get wantKeepAlive => true;
}
