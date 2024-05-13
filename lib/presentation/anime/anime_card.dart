import 'package:anime_explore/models/anime.dart';
import 'package:anime_explore/utils/constants/colors.dart';
import 'package:anime_explore/utils/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class AnimeCard extends StatelessWidget {
  final Anime anime;
  const AnimeCard(this.anime, {super.key});

  static const double height = 150;
  static const double imageWidth = 100;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              anime.image.imageUrl,
              width: imageWidth,
              height: height,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    anime.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: TSizes.fontSizeLg,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
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
                  const SizedBox(height: 8),
                  Text(
                    anime.synopsis,
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
    );
  }
}
