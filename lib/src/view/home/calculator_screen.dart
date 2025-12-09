import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmath_ai_calculator/core/colors/app_palette.dart';
import 'package:mindmath_ai_calculator/src/controller/bloc/arithmetical/arithmetical_bloc.dart';
import 'package:mindmath_ai_calculator/src/view/home/widgets/calc_button.dart';

import '../../../core/common/costume_toggle.dart';
import 'widgets/calc_datas.dart';

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
          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 19.0),
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
                                double size = 64;
                                if (state is ResultState) {
                                  size = 24;
                                }
                                if (state is ContinueState) {
                                  size = 64;
                                }
                                return AnimatedDefaultTextStyle(
                                  duration: const Duration(milliseconds: 200),
                                  style: TextStyle(
                                    fontSize: size,
                                    fontWeight: FontWeight.w400,
                                    color:
                                        Theme.of(context).brightness ==
                                            Brightness.dark
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                  child: Text(
                                    mainInputController.text.isEmpty
                                        ? "0"
                                        : mainInputController.text,
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
                        double size = 24;
                        String result = "";
                        if (state is ListenerState) {
                          size = 24;
                          result = state.result;
                        }

                        if (state is ResultState) {
                          size = 64;
                          result = state.result;
                        }
                        return AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: TextStyle(
                            fontSize: size,
                            fontWeight: FontWeight.w400,
                            color:
                                Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black,
                          ),

                          child: Text(result),
                        );
                      },
                    ),

                    SizedBox(height: 20),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: GridView.builder(
                  itemCount: calcData.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    childAspectRatio: 1.0,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    final item = calcData[index];
                    return _buildCalcItem(
                      data: item["value"],
                      isWhite: item["white"],
                      isBlack: item["black"],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCalcItem({
    required dynamic data,
    required Color isWhite,
    required Color isBlack,
  }) {
    return CalcButton(
      text: data is String ? data : null,
      iconData: data is IconData ? data : null,
      isBlack: isBlack,
      isWhite: isWhite,
      onTap: () {
        log(data.toString());
        context.read<ArithmeticalBloc>().add(
          ArithmeticalTapEvent(expression: data),
        );
      },
    );
  }
}
