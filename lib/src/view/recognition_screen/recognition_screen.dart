import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mindmath_ai_calculator/core/colors/app_palette.dart';
import 'package:mindmath_ai_calculator/core/common/custome_alertbox.dart';
import 'package:mindmath_ai_calculator/core/common/custome_appbar.dart';
import 'package:mindmath_ai_calculator/core/common/custome_options.dart';
import 'package:mindmath_ai_calculator/core/constant/media_quary.dart';
import 'package:mindmath_ai_calculator/core/images/const_images.dart';
import 'package:mindmath_ai_calculator/src/controller/bloc/cubit/select_operation_cubit.dart';
import 'package:mindmath_ai_calculator/src/controller/cubit/toggile_cubit/toggle_cubit.dart';
import 'package:mindmath_ai_calculator/src/view/recognition_screen/widgets/delete_number_section.dart';
import 'package:mindmath_ai_calculator/src/view/recognition_screen/widgets/image_section.dart';
import 'package:mindmath_ai_calculator/src/view/recognition_screen/widgets/ai_assistant_view.dart';
import 'package:mindmath_ai_calculator/src/controller/cubit/ai_assistant_cubit/ai_assistant_visibility_cubit.dart';
import 'package:mindmath_ai_calculator/src/view/recognition_screen/widgets/operator_selection.dart';
import 'package:mindmath_ai_calculator/src/view/recognition_screen/widgets/preview_section.dart';

class RecognitionScreen extends StatefulWidget {
  final XFile image;
  final List<num> numbers;
  const RecognitionScreen({
    super.key,
    required this.image,
    required this.numbers,
  });

  @override
  State<RecognitionScreen> createState() => _RecognitionScreenState();
}

class _RecognitionScreenState extends State<RecognitionScreen> {
  final String _selectedOperator = '+';
  final List<String> _operators = ['+', '-', 'x', '/', '%'];
  String result = "";

  @override
  void initState() {
    super.initState();
    result = widget.numbers.join(" $_selectedOperator ");
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AIAssistantVisibilityCubit(),
      child: BlocListener<SelectOperationCubit, String>(
        listener: (context, state) {
          result = widget.numbers.join(state);
        },
        child: Scaffold(
          appBar: CustomAppBar(
            title: 'Review & Calculate',
            isTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  CustomCupertinoDialog.show(
                    context: context,
                    title: 'Need Help?',
                    message:
                        "This module provides advanced image recognition for user-selected images, powered by AI with full offline support. It accurately detects numerical data and intelligently processes the extracted values to perform mathematical operations and generate precise results.",
                  );
                },
                icon: Icon(Icons.help_outline),
              ),
            ],
          ),
          body: SafeArea(
            child: Stack(
              children: [
                BlocBuilder<AIAssistantVisibilityCubit, bool>(
                  builder: (context, isVisible) {
                    return isVisible
                        ? const Positioned.fill(child: AIAssistantView())
                        : const SizedBox.shrink();
                  },
                ),
                Column(
                  mainAxisAlignment: .start,
                  crossAxisAlignment: .start,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            hight(ctx: context, height: 0.005),
                            ImageSection(widget: widget),
                            hight(ctx: context, height: 0.02),
                            Text(
                              'AI-Powered Image Recognition?',
                              style: TextStyle(
                                color: AppPalette.blue,
                                fontWeight: .bold,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                            Text('1. How is it achieved?'),
                            Text('2. AI-powered recognition support.'),

                            Builder(
                              builder: (context) {
                                final isEnabled = context
                                    .watch<ToggleCubit>()
                                    .state;
                                return TextButton(
                                  onPressed: () {
                                    BottomSheetOptions().showBottomSheet(
                                      mainText: 'AI-Powered Image Recognition',
                                      subText:
                                          'Leverage intelligent recognition powered by AI, following established guidelines. AI support may have certain limitations.',

                                      context: context,
                                      screenHeight: MediaQuery.of(
                                        context,
                                      ).size.height,
                                      screenWidth: MediaQuery.of(
                                        context,
                                      ).size.width,
                                      actionLeft: () {
                                        CustomCupertinoDialog.show(
                                          context: context,
                                          title: 'Working Guidelines',
                                          message:
                                              "AI-powered image recognition monitors and accurately detects numerical data. When online, cloud-based AI is utilized; otherwise, an offline model is used for detection. AI support may be subject to daily usage limits. Activating the AI Assistant enables advanced AI recognition features along with a visual mesh effect to indicate AI-based processing.",
                                        );
                                      },
                                      lottieLeft: needHelp,
                                      textLeft: 'How does it work?',
                                      lottieRight: aiAssistant,
                                      textRight: 'AI Assistant',
                                      actionRight: () {
                                        context
                                            .read<AIAssistantVisibilityCubit>()
                                            .toggle();
                                        Navigator.pop(context);
                                      },
                                      currentTheme: isEnabled,
                                    );
                                  },
                                  child: Text(
                                    'AI - Assistant',
                                    style: TextStyle(
                                      color: AppPalette.blue,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                );
                              },
                            ),
                            hight(ctx: context, height: 0.02),
                            DeletedNumberSection(widget: widget),
                            hight(ctx: context, height: 0.02),

                            OperatorSelection(operators: _operators),
                            hight(ctx: context, height: 0.025),
                            PreviewSection(widget: widget),
                            hight(ctx: context, height: 0.02),
                            BlocBuilder<ToggleCubit, bool>(
                              builder: (context, isEnable) {
                                return RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: "Generate Result? ",
                                        style: TextStyle(
                                          color: isEnable
                                              ? AppPalette.white
                                              : AppPalette.black,
                                          fontSize: 15,
                                        ),
                                      ),
                                      TextSpan(
                                        text: "Tab to Result",
                                        style: const TextStyle(
                                          color: AppPalette.blue,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold,
                                          decoration: TextDecoration.underline,
                                        ),
                                        recognizer: TapGestureRecognizer()
                                          ..onTap = () {
                                            Navigator.pop(context, result);
                                          },
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
