import 'package:anime_explore/models/anime.dart';
import 'package:anime_explore/utils/constants/colors.dart';
import 'package:anime_explore/utils/constants/sizes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
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
        actions: [
          IconButton(
            icon: Icon(Icons.adaptive.share),
            onPressed: _share,
          ),
        ],
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
                      anime.titleEnglish ?? anime.title,
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
                      anime.type,
                      style: const TextStyle(
                        color: TColors.grey,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      anime.genres.map((e) => e.name).join(", "),
                      style: const TextStyle(
                        fontSize: TSizes.fontSizeMd,
                        color: TColors.grey,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _TableInfo(anime),
                    const SizedBox(height: 10),
                    const Divider(color: TColors.grey),
                    const SizedBox(height: 10),
                    _Synopsis(anime.synopsis ?? ""),
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
            onPressed: () => _openTrailer(context),
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
                      child: _image(width),
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

  Widget _image(double size) {
    // Load full image if available
    // Otherwise, load the smaller image
    // If the smaller image is not available, show a shimmer
    return CachedNetworkImage(
      imageUrl: anime.image.largeImageUrl,
      width: size,
      height: size,
      fit: BoxFit.cover,
      placeholder: (context, url) => CachedNetworkImage(
        imageUrl: anime.image.imageUrl,
        width: size,
        height: size,
        placeholder: (context, url) => _imageShimmer(),
      ),
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

  void _openTrailer(BuildContext context) async {
    final String? youtubeUrl = anime.trailer.url;
    if (youtubeUrl != null && youtubeUrl.isNotEmpty) {
      final Uri uri = Uri.parse(youtubeUrl);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text(
                "Failed to detect any supported application to open the trailer."),
            duration: const Duration(seconds: 5),
            action: anime.trailer.url != null
                ? SnackBarAction(
                    label: "Share Link",
                    onPressed: _shareTrailer,
                  )
                : null,
          ),
        );
      }
    }
  }

  void _share() {
    Share.shareUri(Uri.parse(anime.url));
  }

  void _shareTrailer() {
    if (anime.trailer.url == null) return;
    Share.shareUri(Uri.parse(anime.trailer.url!));
  }
}

class _TableInfo extends StatelessWidget {
  final Anime anime;
  const _TableInfo(this.anime);

  @override
  Widget build(BuildContext context) {
    List<List<String>> data = [
      ["Status", anime.status],
      ["Episodes", anime.episodes.toString()],
      ["Duration", anime.duration],
      ["Rating", anime.rating ?? "-"],
      ["Studios", anime.studios.map((e) => e.name).join(", ")],
      ["Producers", anime.producers.map((e) => e.name).join(", ")],
      ["Licensors", anime.licensors.map((e) => e.name).join(", ")],
    ];

    return Container(
      decoration: BoxDecoration(
        color: TColors.black,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Column(
          children: [
            for (int i = 0; i < data.length; i++)
              _card(data[i][0], data[i][1], i),
          ],
        ),
      ),
    );
  }

  Widget _card(String key, String value, int i) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
      decoration: BoxDecoration(
        color: i % 2 == 0 ? TColors.black : TColors.darkBlack,
      ),
      child: Row(children: [
        Expanded(flex: 1, child: Text(key)),
        Expanded(flex: 3, child: Text(value)),
      ]),
    );
  }
}

class _Synopsis extends StatefulWidget {
  final String synopsis;
  const _Synopsis(this.synopsis);

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
