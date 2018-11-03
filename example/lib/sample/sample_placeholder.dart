import 'package:flutter/material.dart';

class SamplePlaceholder extends StatelessWidget {
  final Color color;

  SamplePlaceholder(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
    );
  }
}