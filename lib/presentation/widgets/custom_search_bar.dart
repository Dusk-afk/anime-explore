import 'package:anime_explore/utils/constants/colors.dart';
import 'package:flutter/material.dart';

class CustomSearchBar extends StatelessWidget {
  final FocusNode? focusNode;
  final TextEditingController? controller;
  final String? hintText;
  final ValueChanged<String>? onChanged;

  const CustomSearchBar({
    super.key,
    this.focusNode,
    this.controller,
    this.hintText,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          focusNode: focusNode,
          controller: controller,
          onChanged: onChanged,
          cursorColor: TColors.white,
          style: const TextStyle(
            color: TColors.white,
          ),
          decoration: InputDecoration(
            hintText: hintText,
            contentPadding: const EdgeInsets.only(left: 30),
            fillColor: TColors.darkerGrey,
          ),
        ),
        const Positioned(
          left: 10,
          top: 0,
          bottom: 0,
          child: Icon(
            Icons.search,
            color: TColors.white,
            size: 16,
          ),
        )
      ],
    );
  }
}
