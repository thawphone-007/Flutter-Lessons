import 'package:flutter/material.dart';

import '../widget/my_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Media Library App"), centerTitle: true),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Center(child: Text("Home Screen"))],
      ),
      bottomNavigationBar: MyNavBar(),
    );
  }
}

