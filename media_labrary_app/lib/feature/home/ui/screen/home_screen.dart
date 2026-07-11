import 'package:flutter/material.dart';
import 'package:media_labrary_app/feature/blog/ui/blog_screen.dart';

import '../widget/my_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Media Library App"), centerTitle: true),
      body: BlogScreen(),
      bottomNavigationBar: MyNavBar(),
    );
  }
}
