import 'package:anime_explore/models/anime.dart';
import 'package:anime_explore/utils/constants/colors.dart';
import 'package:anime_explore/utils/constants/sizes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

class AnimePage extends StatelessWidget {
  final Anime anime;
  const AnimePage(this.anime, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        surfaceTintColor: TColors.darkBlack,
        shadowColor: TColors.darkBlack,
        scrolledUnderElevation: 1,
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          Opacity(
            opacity: 0.15,
            child: CachedNetworkImage(
              imageUrl: anime.image.largeImageUrl,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.transparent,
                    TColors.darkBlack,
                    TColors.darkBlack,
                    TColors.darkBlack,
                  ],
                ),
              ),
            ),
          ),
          ListView(
            children: [
              const SizedBox(height: 16),
              _thumbnail(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      anime.title,
                      style: const TextStyle(
                        fontFamily: "Manga",
                        fontSize: 38,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          "${anime.score ?? "-"}",
                          style: const TextStyle(color: Colors.yellow),
                        ),
                        const SizedBox(width: 5),
                        if (anime.scoredBy != null)
                          Text(
                            "(${anime.scoredBy ?? 0})",
                            style: const TextStyle(color: TColors.grey),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      anime.genres.map((e) => e.name).join(", "),
                      style: const TextStyle(
                        fontSize: TSizes.fontSizeMd,
                        color: TColors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Episodes: ${anime.episodes}",
                      style: const TextStyle(
                        fontSize: TSizes.fontSizeMd,
                        color: TColors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Duration: ${anime.duration}",
                      style: const TextStyle(
                        fontSize: TSizes.fontSizeMd,
                        color: TColors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Divider(color: TColors.grey),
                    const SizedBox(height: 10),
                    _Synopsis(anime.synopsis),
                    const SizedBox(height: 10),
                    const Divider(color: TColors.grey),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _thumbnail() {
    return LayoutBuilder(
      builder: (context, constraints) {
        double width = constraints.maxWidth * 0.75;
        return Center(
          child: TextButton(
            onPressed: _openTrailer,
            style: ButtonStyle(
              padding: MaterialStateProperty.all(EdgeInsets.zero),
              minimumSize: MaterialStateProperty.all(Size.zero),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              overlayColor: MaterialStateProperty.all(Colors.transparent),
            ),
            child: Container(
              width: width,
              height: width,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                border: Border.all(
                  color: Colors.white,
                  width: 1,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Stack(
                  children: [
                    Hero(
                      tag: anime.malId,
                      child: CachedNetworkImage(
                        imageUrl: anime.image.largeImageUrl,
                        width: width,
                        height: width,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => _imageShimmer(),
                      ),
                    ),
                    if (anime.trailer.url != null &&
                        anime.trailer.url!.isNotEmpty)
                      Center(
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: TColors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                Icons.play_circle_fill,
                                color: TColors.white,
                                size: 50,
                              ),
                              SizedBox(width: 10),
                              Text(
                                "Watch trailer",
                                style: TextStyle(
                                  fontSize: TSizes.fontSizeMd,
                                  fontWeight: FontWeight.bold,
                                  color: TColors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _imageShimmer() {
    return Shimmer.fromColors(
      baseColor: TColors.darkBlack,
      highlightColor: TColors.black,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: TColors.grey,
      ),
    );
  }

  void _openTrailer() async {
    final String? youtubeUrl = anime.trailer.url;
    if (youtubeUrl != null && youtubeUrl.isNotEmpty) {
      final Uri uri = Uri.parse(youtubeUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      }
    }
  }
}

class _Synopsis extends StatefulWidget {
  final String synopsis;
  const _Synopsis(this.synopsis, {super.key});

  @override
  State<_Synopsis> createState() => __SynopsisState();
}

class __SynopsisState extends State<_Synopsis> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    if (_expanded || widget.synopsis.length < 200) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.synopsis),
          if (_expanded) ...[
            const SizedBox(height: 4),
            TextButton(
              onPressed: () {
                setState(() {
                  _expanded = false;
                });
              },
              child: const Text("Read less"),
            ),
          ]
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${widget.synopsis.substring(0, 200)}..."),
        const SizedBox(height: 4),
        TextButton(
          onPressed: () {
            setState(() {
              _expanded = true;
            });
          },
          child: const Text("Read more"),
        ),
      ],
    );
  }
}
