import 'package:flutter/material.dart';
import 'package:mindmath_ai_calculator/src/view/recognition_screen/recognition_screen.dart';

class DeletedNumberSection extends StatelessWidget {
  const DeletedNumberSection({super.key, required this.widget});

  final RecognitionScreen widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        Text(
          "Detected Numbers",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.underline,
          ),
          textAlign: TextAlign.start,
        ),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: widget.numbers.isEmpty
              ? [
                  const Text(
                    "No numbers found",
                    style: TextStyle(color: Colors.grey),
                  ),
                ]
              : List.generate(widget.numbers.length, (index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Text(
                      widget.numbers[index].toString(),
                      style: TextStyle(fontSize: 16),
                    ),
                  );
                }),
        ),
      ],
    );
  }
}
