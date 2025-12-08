import 'package:flutter/material.dart';
import 'package:mindmath_ai_calculator/core/colors/app_palette.dart';
import 'package:mindmath_ai_calculator/src/view/home/widgets/calc_button.dart';

import '../../../core/common/costume_toggle.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
          child: Column(
            children: [
              Expanded(
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    CostumeToggle(),
                    Text(
                      '6,291÷5',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '1,258.2',
                      style: TextStyle(
                        fontSize: 64,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    _buildButtonRow(
                      ['AC', Icons.mic_sharp, Icons.percent, '÷'],
                      [
                        Colors.grey[800]!,
                        Colors.grey[800]!,
                        Colors.grey[800]!,
                        AppPalette.blue,
                      ],
                      [
                        AppPalette.hint,
                        AppPalette.hint,
                        AppPalette.hint,
                        AppPalette.blue,
                      ],
                    ),
                    _buildButtonRow(
                      ['7', '8', '9', 'x'],
                      [
                        AppPalette.black2,
                        AppPalette.black2,
                        AppPalette.black2,
                        AppPalette.blue,
                      ],
                      [
                        const Color.fromARGB(255, 244, 244, 244),
                        const Color.fromARGB(255, 244, 244, 244),
                        const Color.fromARGB(255, 244, 244, 244),
                        AppPalette.blue,
                      ],
                    ),
                    _buildButtonRow(
                      ['4', '5', '6', '-'],
                      [
                        AppPalette.black2,
                        AppPalette.black2,
                        AppPalette.black2,
                        AppPalette.blue,
                      ],
                      [
                        const Color.fromARGB(255, 244, 244, 244),
                        const Color.fromARGB(255, 244, 244, 244),
                        const Color.fromARGB(255, 244, 244, 244),
                        AppPalette.blue,
                      ],
                    ),
                    _buildButtonRow(
                      ['1', '2', '3', '+'],
                      [
                        AppPalette.black2,
                        AppPalette.black2,
                        AppPalette.black2,
                        AppPalette.blue,
                      ],
                      [
                        const Color.fromARGB(255, 244, 244, 244),
                        const Color.fromARGB(255, 244, 244, 244),
                        const Color.fromARGB(255, 244, 244, 244),
                        AppPalette.blue,
                      ],
                    ),
                    _buildButtonRow(
                      ['.', '0', Icons.backspace_outlined, '='],
                      [
                        AppPalette.black2,
                        AppPalette.black2,
                        AppPalette.black2,
                        AppPalette.blue,
                      ],
                      [
                        const Color.fromARGB(255, 244, 244, 244),
                        const Color.fromARGB(255, 244, 244, 244),
                        const Color.fromARGB(255, 244, 244, 244),
                        AppPalette.blue,
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildButtonRow(
    List<dynamic> data,
    List<Color> isWhite,
    List<Color> isBlack,
  ) {
    return Expanded(
      child: Row(
        children: List.generate(data.length, (index) {
          return Expanded(
            child: CalcButton(
              text: data[index] is String ? data[index] : null,
              iconData: data[index] is IconData ? data[index] : null,
              isBlack: isBlack[index],
              isWhite: isWhite[index],
              onTap: () {},
            ),
          );
        }),
      ),
    );
  }
}
