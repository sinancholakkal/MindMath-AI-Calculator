import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mindmath_ai_calculator/src/view/recognition_screen/recognition_screen.dart';

class ImageSection extends StatelessWidget {
  const ImageSection({super.key, required this.widget});

  final RecognitionScreen widget;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: .centerLeft,
      child: Container(
        height: 150,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(0)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(0),
          child: Image.file(
            File(widget.image.path),
            fit: BoxFit.contain,
            width: double.infinity,
          ),
        ),
      ),
    );
  }
}
