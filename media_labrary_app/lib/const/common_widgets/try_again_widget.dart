import 'package:flutter/material.dart';

class TryAgainWidget extends StatelessWidget {
  const TryAgainWidget({super.key, required this.colorScheme});

  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Something Wrong!",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                OutlinedButton(
                  onPressed: () {},
                  child: Text(
                    "Try Again",
                    style: TextStyle(fontWeight: FontWeight(700)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
