import 'package:flutter/material.dart';

import '../../../blog/ui/screens/blog_screen.dart';
import '../widgets/my_bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Media Library App"),
        centerTitle: true,
      ),
      body: BlogScreen(),
      bottomNavigationBar: MyBottomNavBar(),
    );
  }
}


