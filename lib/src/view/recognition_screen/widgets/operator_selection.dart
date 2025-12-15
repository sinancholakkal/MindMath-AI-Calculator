import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmath_ai_calculator/core/colors/app_palette.dart';
import 'package:mindmath_ai_calculator/core/constant/media_quary.dart';
import 'package:mindmath_ai_calculator/src/controller/bloc/cubit/select_operation_cubit.dart';
import 'package:mindmath_ai_calculator/src/controller/cubit/toggile_cubit/toggle_cubit.dart';

class OperatorSelection extends StatelessWidget {
  const OperatorSelection({super.key, required List<String> operators})
    : _operators = operators;

  final List<String> _operators;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Select Operation",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            decoration: TextDecoration.underline,
          ),
          textAlign: TextAlign.start,
        ),
        hight(ctx: context, height: 0.01),
        BlocBuilder<SelectOperationCubit, String>(
          builder: (context, state) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(_operators.length, (index) {
                final isSelected = state == _operators[index];
                return GestureDetector(
                  onTap: () {
                    context.read<SelectOperationCubit>().selectOperation(
                      _operators[index],
                    );
                  },
                  child: BlocBuilder<ToggleCubit, bool>(
                    builder: (context, isEnable) {
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(
                            color: isSelected == isEnable
                                ? AppPalette.black
                                : AppPalette.white,
                            width: isSelected ? 1 : 0,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            _operators[index],
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                );
              }),
            );
          },
        ),
      ],
    );
  }
}
