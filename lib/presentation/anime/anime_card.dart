import 'package:anime_explore/models/anime.dart';
import 'package:anime_explore/presentation/anime/anime_page.dart';
import 'package:anime_explore/utils/constants/colors.dart';
import 'package:anime_explore/utils/constants/sizes.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AnimeCard extends StatelessWidget {
  final Anime anime;
  final bool showRank;
  const AnimeCard(this.anime, {super.key, this.showRank = false});

  static const double height = 150;
  static const double imageWidth = 100;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.only(bottom: 16),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AnimePage(anime),
          ));
        },
        style: ButtonStyle(
          padding: MaterialStateProperty.all(EdgeInsets.zero),
          minimumSize: MaterialStateProperty.all(Size.zero),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          )),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Hero(
              tag: anime.malId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: _imageWidget(),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 6),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      text: TextSpan(
                        children: [
                          if (showRank && anime.rank != null)
                            TextSpan(
                              text: "${anime.rank}. ",
                              style: const TextStyle(
                                fontFamily: "Manga",
                                fontSize: TSizes.fontSizeLg,
                                color: TColors.primary,
                              ),
                            ),
                          TextSpan(
                            text: anime.titleEnglish ?? anime.title,
                            style: const TextStyle(
                              fontSize: TSizes.fontSizeLg,
                              fontWeight: FontWeight.bold,
                              color: TColors.white,
                            ),
                          )
                        ],
                      ),
                    ),
                    Text(
                      anime.type,
                      style: const TextStyle(color: TColors.grey),
                    ),
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.yellow,
                          size: TSizes.iconSm,
                        ),
                        const SizedBox(width: 2),
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
                    const SizedBox(height: 8),
                    Text(
                      anime.synopsis ?? "",
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: TSizes.fontSizeXs,
                        color: TColors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _imageWidget() {
    return SizedBox(
      width: imageWidth,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: CachedNetworkImage(
          imageUrl: anime.image.imageUrl,
          fit: BoxFit.cover,
          placeholder: (context, url) => _imageShimmer(),
        ),
      ),
    );
  }

  Widget _imageShimmer() {
    return SizedBox(
      width: imageWidth,
      height: height,
      child: Shimmer.fromColors(
        baseColor: TColors.black,
        highlightColor: TColors.darkerGrey,
        child: Container(
          decoration: BoxDecoration(
            color: TColors.grey,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
