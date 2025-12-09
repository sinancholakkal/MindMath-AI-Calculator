import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:mindmath_ai_calculator/core/colors/app_palette.dart';
import 'package:mindmath_ai_calculator/src/controller/bloc/arithmetical/arithmetical_bloc.dart';
import 'package:mindmath_ai_calculator/src/view/home/widgets/calc_button.dart';

import '../../../core/common/costume_toggle.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  late TextEditingController mainInputController;
  late ScrollController mainInputScrollController;
  @override
  void initState() {
    super.initState();
    mainInputScrollController = ScrollController();
    mainInputController = TextEditingController();
    mainInputController.addListener(() {
      context.read<ArithmeticalBloc>().add(
        ArithmeticalListenerEvent(expression: mainInputController.text),
      );
    });
  }

  @override
  void dispose() {
    mainInputController.dispose();
    mainInputScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 14.0),
          child: Column(
            children: [
              CostumeToggle(),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    //Main input and result
                    Container(
                      width: double.infinity,
                      alignment: Alignment.centerRight,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        reverse: true,
                        child:
                            BlocConsumer<ArithmeticalBloc, ArithmeticalState>(
                              listener: (context, state) {
                                if (state is ContinueState) {
                                  mainInputController.text = state.mainInput;
                                }
                              },

                              builder: (context, state) {
                                return Text(
                                  mainInputController.text.isEmpty
                                      ? "0"
                                      : mainInputController.text,
                                  style: TextStyle(
                                    fontSize: state is ResultState ? 24 : 64,
                                    fontWeight: FontWeight.w400,
                                  ),
                                );
                              },
                            ),
                      ),
                    ),
                    SizedBox(height: 10),
                    //Instand result
                    BlocBuilder<ArithmeticalBloc, ArithmeticalState>(
                      builder: (context, state) {
                        String result = state is ListenerState
                            ? state.result
                            : "";
                        if (state is ResultState) {
                          result = state.result;
                        }
                        return Text(
                          result,
                          style: TextStyle(
                            fontSize: state is ResultState ? 64 : 24,
                            fontWeight: FontWeight.w400,
                          ),
                        );
                      },
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
                      ['AC', Icons.mic_sharp, "%", '÷'],
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
              onTap: () {
                log(data[index].toString());
                context.read<ArithmeticalBloc>().add(
                  ArithmeticalTapEvent(expression: data[index]),
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
