import 'package:flutter/material.dart';

class SamplePlaceholder extends StatelessWidget {
  final Color color;
  final String title;

  SamplePlaceholder(this.title, {this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: color,
      child: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
