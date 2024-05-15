import 'package:anime_explore/models/anime_order_by_enum.dart';
import 'package:anime_explore/models/anime_rating_enum.dart';
import 'package:anime_explore/models/anime_search_args.dart';
import 'package:anime_explore/models/anime_sort_enum.dart';
import 'package:anime_explore/models/anime_type_enum.dart';
import 'package:anime_explore/models/wrappeed.dart';
import 'package:anime_explore/utils/theme/input_decoration_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';

class FilterSearchDialog extends StatefulWidget {
  final AnimeSearchArgs args;
  const FilterSearchDialog({super.key, required this.args});

  @override
  State<FilterSearchDialog> createState() => _FilterSearchDialogState();
}

class _FilterSearchDialogState extends State<FilterSearchDialog> {
  late AnimeType? _animeTypeSelected = widget.args.type;
  late AnimeRating? _animeRatingSelected = widget.args.rating;
  late AnimeOrderBy? _animeOrderBySelected = widget.args.orderBy;
  late AnimeSort? _animeSortSelected = widget.args.sort;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.black,
      child: Theme(
        data: Theme.of(context).copyWith(
          inputDecorationTheme: TInputDecorationTheme.darkTheme,
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              const Center(
                child: Text(
                  "Filters",
                  style: TextStyle(
                    fontFamily: "manga",
                    fontSize: 26,
                  ),
                ),
              ),
              const SizedBox(height: 22),
              const Text(" Type"),
              const SizedBox(height: 4),
              DropdownButtonFormField<AnimeType?>(
                items: [null, ...AnimeType.values]
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e?.label ?? "All"),
                        ))
                    .toList(),
                value: _animeTypeSelected,
                onChanged: (value) {
                  setState(() {
                    _animeTypeSelected = value;
                  });
                },
              ),
              const SizedBox(height: 22),
              const Text(" Rating"),
              const SizedBox(height: 4),
              DropdownButtonFormField<AnimeRating?>(
                items: [null, ...AnimeRating.values]
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e?.label ?? "All"),
                        ))
                    .toList(),
                value: _animeRatingSelected,
                onChanged: (value) {
                  setState(() {
                    _animeRatingSelected = value;
                  });
                },
              ),
              const SizedBox(height: 22),
              const Text(" Order By"),
              const SizedBox(height: 4),
              DropdownButtonFormField<AnimeOrderBy?>(
                items: [null, ...AnimeOrderBy.values]
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e?.label ?? "None"),
                        ))
                    .toList(),
                value: _animeOrderBySelected,
                onChanged: (value) {
                  setState(() {
                    _animeOrderBySelected = value;
                  });
                },
              ),
              const SizedBox(height: 22),
              const Text(" Sort"),
              const SizedBox(height: 4),
              DropdownButtonFormField<AnimeSort?>(
                items: [null, ...AnimeSort.values]
                    .map((e) => DropdownMenuItem(
                          value: e,
                          child: Text(e?.label ?? "None"),
                        ))
                    .toList(),
                value: _animeSortSelected,
                onChanged: (value) {
                  setState(() {
                    _animeSortSelected = value;
                  });
                },
              ),
              const SizedBox(height: 32),
              Center(
                child: PlatformElevatedButton(
                  onPressed: _onApplyPressed,
                  color: Theme.of(context).primaryColor,
                  child: const Text("Apply"),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  void _onApplyPressed() {
    final newArgs = widget.args.copyWith(
      type: Wrapped(_animeTypeSelected),
      rating: Wrapped(_animeRatingSelected),
      orderBy: Wrapped(_animeOrderBySelected),
      sort: Wrapped(_animeSortSelected),
    );
    Navigator.of(context).pop(newArgs);
  }
}
