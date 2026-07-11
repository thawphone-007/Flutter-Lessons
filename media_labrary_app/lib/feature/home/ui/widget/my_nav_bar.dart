import 'package:flutter/material.dart';

class MyNavBar extends StatelessWidget {
  const MyNavBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: [
        NavigationDestination(icon: Icon(Icons.home), label: "Home"),
        NavigationDestination(
          icon: Icon(Icons.video_collection_outlined),
          label: "Video",
        ),
        NavigationDestination(icon: Icon(Icons.audiotrack), label: "Audio"),
        NavigationDestination(
          icon: Icon(Icons.picture_as_pdf_outlined),
          label: "PDF",
        ),
        NavigationDestination(icon: Icon(Icons.settings), label: "Settings"),
      ],
    );
  }
}
