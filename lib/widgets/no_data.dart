import 'package:flutter/material.dart';

// text to show when no kindergartens are found
class NoKindergartens extends StatelessWidget {
  const NoKindergartens({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('No kindergartens found', style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
      ),
    );
  }
}