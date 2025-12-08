import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmath_ai_calculator/core/colors/app_palette.dart';

import '../../src/controller/toggle_cubit.dart';

class CostumeToggle extends StatelessWidget {
  const CostumeToggle({super.key});

  final animationDuration = const Duration(milliseconds: 400);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<ToggleCubit>().toggle();
      },
      child: BlocBuilder<ToggleCubit, bool>(
        builder: (context, isEnabled) {
          return AnimatedContainer(
            duration: animationDuration,
            height: 30,
            width: 65,
            decoration: BoxDecoration(
              color: isEnabled
                  ? AppPalette.black2.withValues(alpha: 0.6)
                  : AppPalette.hint,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Icon(Icons.dark_mode, size: 20),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 9),
                      child: Icon(Icons.light_mode, size: 20),
                    ),
                  ],
                ),
                AnimatedAlign(
                  alignment: isEnabled
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  duration: animationDuration,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 2),
                    child: AnimatedContainer(
                      duration: animationDuration,
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isEnabled ? AppPalette.black2 : AppPalette.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
