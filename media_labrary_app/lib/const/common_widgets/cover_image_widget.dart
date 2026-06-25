import 'package:flutter/material.dart';

class CoverImageWidget extends StatelessWidget {
  const CoverImageWidget({super.key, this.imageUrl});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: imageUrl == null
            ? Container(
                color: colorScheme.surfaceContainerHighest,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.image_outlined, size: 80),
                    SizedBox(height: 8,),
                    Text("No Photo to Show")
                  ],
                ),
              )
            : Image.network(
                imageUrl!,
                fit: BoxFit.cover,
                loadingBuilder: (context, child, progress) {
                  if(progress == null ){
                    return child;
                  }
                  return Container(
                    color: colorScheme.surfaceContainerHighest,
                    alignment: Alignment.center,
                    child: CircularProgressIndicator(),
                  );
                },
              ),
      ),
    );
  }
}


