import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmath_ai_calculator/core/colors/app_palette.dart';
import 'package:mindmath_ai_calculator/core/common/scanner_button.dart';

import '../../src/controller/cubit/toggile_cubit/toggle_cubit.dart';

class CostumeToggle extends StatelessWidget {
  const CostumeToggle({super.key});

  final animationDuration = const Duration(milliseconds: 200);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: .center,
      crossAxisAlignment: .center,
      children: [
        GestureDetector(
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
                  borderRadius: .circular(40),
                ),
                child: Stack(
                  alignment: .center,
                  children: [
                    Row(
                      mainAxisAlignment: .center,
                      children: const [
                        Padding(
                          padding: .only(left: 10),
                          child: Icon(Icons.dark_mode, size: 20),
                        ),
                        Padding(
                          padding: .only(right: 9),
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
                        padding: .symmetric(horizontal: 2),
                        child: AnimatedContainer(
                          duration: animationDuration,
                          width: 28,
                          height: 28,
                          decoration: BoxDecoration(
                            shape: .circle,
                            color: isEnabled
                                ? AppPalette.black2
                                : AppPalette.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        const SizedBox(width: 10),
        ScannerButton(),
      ],
    );
  }
}
