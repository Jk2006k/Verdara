import 'package:flutter/material.dart';

class TreeWidget extends StatelessWidget {
  final int battery;

  const TreeWidget({
    super.key,
    required this.battery,
  });

  @override
  Widget build(BuildContext context) {
    String tree;

    if (battery < 30) {
      tree = '🌱';
    } else if (battery < 70) {
      tree = '🌳';
    } else {
      tree = '🌳🌸';
    }

    return Text(
      tree,
      style: const TextStyle(
        fontSize: 100,
      ),
    );
  }
}