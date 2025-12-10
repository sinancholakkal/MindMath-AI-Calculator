import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmath_ai_calculator/src/controller/bloc/cubit/select_operation_cubit.dart';
import 'package:mindmath_ai_calculator/src/view/recognition_screen/recognition_screen.dart';

class PreviewSection extends StatelessWidget {
  const PreviewSection({
    super.key,
    required this.widget,
    required String formattedExpression,
  }) : _formattedExpression = formattedExpression;

  final RecognitionScreen widget;
  final String _formattedExpression;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      children: [
        const Text(
          "Equation Preview",
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.grey.shade900,
            borderRadius: BorderRadius.circular(16),
          ),
          child: BlocBuilder<SelectOperationCubit, String>(
            builder: (context, state) {
              return Text(
                widget.numbers.isEmpty ? "0" : widget.numbers.join(" $state "),
                style: const TextStyle(
                  fontSize: 24,
                  fontFamily: 'monospace',
                  fontWeight: FontWeight.bold,
                  color: Colors.greenAccent,
                ),
                textAlign: TextAlign.center,
              );
            },
          ),
        ),
      ],
    );
  }
}
