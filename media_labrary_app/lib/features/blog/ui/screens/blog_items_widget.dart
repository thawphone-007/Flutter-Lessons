import 'package:flutter/material.dart';
import 'package:media_labrary_app/const/common_widgets/cover_image_widget.dart';

class BlogItemsWidget extends StatelessWidget {
  const BlogItemsWidget({super.key, required this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Column(children: [CoverImageWidget(imageUrl: imageUrl)]);
  }
}
