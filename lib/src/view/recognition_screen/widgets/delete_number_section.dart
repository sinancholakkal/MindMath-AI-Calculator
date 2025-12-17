import 'package:flutter/material.dart';
import 'package:mindmath_ai_calculator/src/view/recognition_screen/recognition_screen.dart';

class DeletedNumberSection extends StatelessWidget {
  const DeletedNumberSection({super.key, required this.numbers});

  final List<num> numbers;

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
          runSpacing: 2,
          children: numbers.isEmpty
              ? [const Text("No numbers found")]
              : List.generate(numbers.length, (index) {
                  return Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 2,
                    ),
                    child: Text(
                      numbers[index].toString(),
                      style: TextStyle(fontSize: 19, fontWeight: .bold),
                    ),
                  );
                }),
        ),
      ],
    );
  }
}
