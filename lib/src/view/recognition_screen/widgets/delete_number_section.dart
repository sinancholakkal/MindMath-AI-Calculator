import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmath_ai_calculator/core/colors/app_palette.dart';
import 'package:mindmath_ai_calculator/core/constant/media_quary.dart';
import 'package:mindmath_ai_calculator/src/controller/cubit/toggile_cubit/toggle_cubit.dart';

class DeletedNumberSection extends StatelessWidget {
  const DeletedNumberSection({super.key, required this.numbers});

  final List<num> numbers;

  @override
  Widget build(BuildContext context) {
    if (numbers.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Text(
            "No numerical data detected",
            style: TextStyle(fontSize: 14),
          ),
        ),
      );
    }

    final isDark = !context.watch<ToggleCubit>().state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.data_array,
              size: 16,
              color: AppPalette.blue.withValues(alpha: 0.8),
            ),
            width(context: context, width: 0.01),
            Text(
              "DETECTED VALUES",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
        Text("Detected values count: ${numbers.length}"),
        hight(ctx: context, height: 0.02),
        Wrap(
          spacing: 12,
          runSpacing: 3,
          children: numbers.map((number) {
            return Container(
              padding: .symmetric(horizontal: 5),

              decoration: BoxDecoration(
                shape: .rectangle,
                color: isDark
                    ? AppPalette.red.withValues(alpha: 0.05)
                    : AppPalette.blue.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: isDark
                      ? AppPalette.white.withValues(alpha: 0.1)
                      : AppPalette.black.withValues(alpha: 0.1),
                ),
              ),
              child: Text(
                number.toString(),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
