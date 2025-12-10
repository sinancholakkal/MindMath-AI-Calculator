import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mindmath_ai_calculator/src/view/recognition_screen/recognition_screen.dart';

class ImageSection extends StatelessWidget {
  const ImageSection({super.key, required this.widget});

  final RecognitionScreen widget;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.file(
          File(widget.image.path),
          fit: BoxFit.cover,
          width: double.infinity,
        ),
      ),
    );
  }
}
