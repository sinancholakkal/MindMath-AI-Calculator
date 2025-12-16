import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmath_ai_calculator/src/controller/bloc/cubit/select_operation_cubit.dart';
import 'package:mindmath_ai_calculator/src/view/recognition_screen/recognition_screen.dart';

class PreviewSection extends StatelessWidget {
  const PreviewSection({super.key, required this.widget});

  final RecognitionScreen widget;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        const Text(
          "Equation Preview",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, decoration: .underline), 
          textAlign: .start,
        ),
        SizedBox(
          width: double.infinity,
          child: BlocBuilder<SelectOperationCubit, String>(
            builder: (context, state) {
              return Text(
                widget.numbers.isEmpty ? "0" : widget.numbers.join(" $state "),
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: .bold,
                  fontFamily: 'monospace',
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
