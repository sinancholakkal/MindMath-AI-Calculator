import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmath_ai_calculator/src/controller/bloc/cubit/select_operation_cubit.dart';
import 'package:mindmath_ai_calculator/src/view/recognition_screen/recognition_screen.dart';

import '../../../../core/colors/app_palette.dart';
import '../../../../core/constant/media_quary.dart';

class PreviewSection extends StatelessWidget {
  const PreviewSection({super.key, required this.numbers});

  final List<num> numbers;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
         Row(
          children: [
            Icon(
              Icons.question_answer_outlined,
              size: 16,
              color: AppPalette.blue.withValues(alpha: 0.8),
            ),
            width(context: context, width: 0.01),
            Text(
              "EQUATION PREVIEW",
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
            ),
          ],
        ),
        SizedBox(
          width: double.infinity,
          child: BlocBuilder<SelectOperationCubit, String>(
            builder: (context, state) {
              return Text(
                numbers.isEmpty ? "0" : numbers.join(" $state  "),
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: .bold,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
