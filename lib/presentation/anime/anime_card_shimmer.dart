import 'package:anime_explore/presentation/anime/anime_card.dart';
import 'package:anime_explore/utils/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class AnimeCardShimmer extends StatelessWidget {
  const AnimeCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AnimeCard.height,
      margin: const EdgeInsets.only(bottom: 16),
      child: Shimmer.fromColors(
        baseColor: TColors.darkBlack,
        highlightColor: TColors.black,
        child: Row(
          children: [
            Container(
              width: AnimeCard.imageWidth,
              decoration: BoxDecoration(
                color: TColors.grey,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 20,
                    decoration: BoxDecoration(
                      color: TColors.grey,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Expanded(
                    child: Container(
                      height: 20,
                      decoration: BoxDecoration(
                        color: TColors.grey,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
