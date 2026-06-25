import 'package:flutter/material.dart';

class EmptyListWidget extends StatelessWidget {
  const EmptyListWidget({
    super.key,
    required this.colorScheme,
    required this.showName,
  });

  final ColorScheme colorScheme;
  final String showName;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: colorScheme.surfaceContainerHighest,
            ),
            padding: EdgeInsets.all(24),
            child: Text(
              showName,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight(700)),
            ),
          ),
        ],
      ),
    );
  }
}
