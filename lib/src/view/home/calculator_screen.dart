import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmath_ai_calculator/src/controller/bloc/arithmetical/arithmetical_bloc.dart';
import 'package:mindmath_ai_calculator/src/controller/bloc/image_pick/image_pick_bloc.dart';
import 'package:mindmath_ai_calculator/src/view/home/widgets/calc_button.dart';
import 'package:mindmath_ai_calculator/src/view/recognition_screen/recognition_screen.dart';

import '../../../core/common/costume_toggle.dart';
import '../../controller/cubit/speech_cubit/speech_cubit.dart';
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
    return BlocListener<ImagePickBloc, ImagePickState>(
      listener: (context, state) async {
        if (state is ImagePickLoaded) {
          mainInputController.text = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  RecognitionScreen(image: state.image, numbers: state.numbers),
            ),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 14.0,
              vertical: 19.0,
            ),
            child: Column(
              children: [
                CostumeToggle(),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      BlocListener<SpeechCubit, SpeechState>(
                        listener: (context, speechState) {
                          if (speechState.isListening) {
                            mainInputController.text =
                                speechState.recognizedText;

                            mainInputController.selection =
                                TextSelection.fromPosition(
                                  TextPosition(
                                    offset: mainInputController.text.length,
                                  ),
                                );
                          }
                        },
                        child: Container(
                          height: 80,
                          alignment: Alignment.centerRight,
                          child:
                              BlocConsumer<ArithmeticalBloc, ArithmeticalState>(
                                listener: (context, state) {
                                  if (state is ContinueState) {
                                    mainInputController.text = state.mainInput;

                                    if (state.cursorPos != null) {
                                      mainInputController.selection =
                                          TextSelection.fromPosition(
                                            TextPosition(
                                              offset: state.cursorPos!.clamp(
                                                0,
                                                mainInputController.text.length,
                                              ),
                                            ),
                                          );
                                    }
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
                                  return SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    reverse: true,
                                    controller: mainInputScrollController,
                                    child: IntrinsicWidth(
                                      child: TextField(
                                        controller: mainInputController,
                                        textAlign: TextAlign.right,
                                        showCursor: true,
                                        readOnly: true,
                                        autofocus: true,
                                        style: TextStyle(
                                          fontSize: size,
                                          fontWeight: FontWeight.w400,
                                          color:
                                              Theme.of(context).brightness ==
                                                  Brightness.dark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        keyboardType: TextInputType.number,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                        ),
                                      ),
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
                                  Theme.of(context).brightness ==
                                      Brightness.dark
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
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
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
      ),
    );
  }

  Widget _buildCalcItem({
    required dynamic data,
    required Color isWhite,
    required Color isBlack,
  }) {
    final speech = context.watch<SpeechCubit>();

    final bool isMic = data == Icons.mic;

    return CalcButton(
      text: data is String ? data : null,
      iconData: isMic
          ? (speech.state.isListening ? Icons.mic : Icons.mic_off)
          : data is IconData
          ? data
          : null,

      isWhite: isMic
          ? (speech.state.isListening ? Colors.blue : isWhite)
          : isWhite,

      isBlack: isMic
          ? (speech.state.isListening ? Colors.blue : isBlack)
          : isBlack,

      onTap: () async {
        if (isMic) {
          final hasPermission = await speech.checkMicPermission();

          if (!hasPermission) {
            return;
          }
          await speech.init();

          if (!speech.state.isListening) {
            speech.startListening();
          } else {
            speech.stopListening();
          }

          return;
        }
        // if (data == Icons.backspace_outlined) {
        //   mainInputController.text =
        //       mainInputController.text.substring(
        //         0,
        //         mainInputController.selection.baseOffset - 1,
        //       ) +
        //       mainInputController.text.substring(
        //         mainInputController.selection.baseOffset,
        //       );
        //   mainInputController.selection = TextSelection.collapsed(
        //     offset: mainInputController.selection.baseOffset - 2,
        //   );

        //   return;
        // }
        context.read<ArithmeticalBloc>().add(
          ArithmeticalTapEvent(
            expression: data,
            mainInput: mainInputController.text,
            cursorPos: mainInputController.selection.baseOffset,
          ),
        );
      },
    );
  }
}
