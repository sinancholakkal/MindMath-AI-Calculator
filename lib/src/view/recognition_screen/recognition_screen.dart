import 'dart:developer';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:glass_fish_button/glass_fish_button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mindmath_ai_calculator/core/colors/app_palette.dart';
import 'package:mindmath_ai_calculator/core/common/custome_alertbox.dart';
import 'package:mindmath_ai_calculator/core/common/custome_appbar.dart';
import 'package:mindmath_ai_calculator/core/common/custome_options.dart';
import 'package:mindmath_ai_calculator/core/constant/media_quary.dart';
import 'package:mindmath_ai_calculator/core/images/const_images.dart';
import 'package:mindmath_ai_calculator/src/controller/bloc/cubit/select_operation_cubit.dart';
import 'package:mindmath_ai_calculator/src/controller/bloc/image_pick/image_pick_bloc.dart';
import 'package:mindmath_ai_calculator/src/controller/cubit/toggile_cubit/toggle_cubit.dart';
import 'package:mindmath_ai_calculator/src/view/recognition_screen/widgets/delete_number_section.dart';
import 'package:mindmath_ai_calculator/src/view/recognition_screen/widgets/image_section.dart';
import 'package:mindmath_ai_calculator/src/view/recognition_screen/widgets/ai_assistant_view.dart';
import 'package:mindmath_ai_calculator/src/controller/cubit/ai_assistant_cubit/ai_assistant_visibility_cubit.dart';
import 'package:mindmath_ai_calculator/src/view/recognition_screen/widgets/operator_selection.dart';
import 'package:mindmath_ai_calculator/src/view/recognition_screen/widgets/preview_section.dart';

class RecognitionScreen extends StatefulWidget {
  const RecognitionScreen({super.key});

  @override
  State<RecognitionScreen> createState() => _RecognitionScreenState();
}

class _RecognitionScreenState extends State<RecognitionScreen> {
  final String _selectedOperator = '+';
  final List<String> _operators = ['+', '-', 'x', '/', '%'];
  String result = "";
  List<num> numbers = [];
  XFile? image;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    result = "";
    numbers.clear();
    image = null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AIAssistantVisibilityCubit(),
      child: MultiBlocListener(
        listeners: [
          BlocListener<SelectOperationCubit, String>(
            listener: (context, state) {
              result = numbers.join(state);
            },
          ),
          BlocListener<ImagePickBloc, ImagePickState>(
            listener: (context, state) {
              if (state is ImageProcessingErrorState) {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.message)));
              }
            },
          ),
        ],
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
                icon: Icon(CupertinoIcons.ellipsis_circle),
              ),
            ],
          ),
          body: SafeArea(
            child: BlocConsumer<ImagePickBloc, ImagePickState>(
              listener: (context, state) {
                if (state is ImagePickLoaded) {
                  numbers = state.numbers;
                  image = state.image;
                  result = numbers.join(_selectedOperator);
                  log("loaded");
                }
              },
              builder: (context, state) {
                if (state is ImagePickLoading) {
                  log("loading");
                  return const AIAssistantView();
                }
                return Stack(
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
                                ImageSection(image: image!),
                                hight(ctx: context, height: 0.02),
                                Text(
                                  'AI-Powered Image Recognition?',
                                  style: TextStyle(
                                    fontWeight: .bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                Text('1. How is it achieved?'),
                                Text('2. AI-powered recognition support.'),
                                hight(ctx: context, height: 0.01),
                                Builder(
                                  builder: (context) {
                                    final isEnabled = context
                                        .watch<ToggleCubit>()
                                        .state;
                                    return AnimatedScale(
                                      duration: const Duration(
                                        milliseconds: 120,
                                      ),
                                      scale: 1,
                                      child: GlassFishButton(
                                        label: 'AI - Assistant',
                                        height: 40,
                                        brightness: .light,
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                        onPressed: () {
                                          BottomSheetOptions().showBottomSheet(
                                            mainText:
                                                'AI-Powered Image Recognition',
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
                                                  .read<
                                                    AIAssistantVisibilityCubit
                                                  >()
                                                  .toggle();
                                              Navigator.pop(context);
                                              context.read<ImagePickBloc>().add(
                                                ImageAiProcessingEvent(
                                                  image: image!,
                                                ),
                                              );
                                            },
                                            currentTheme: isEnabled,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                                hight(ctx: context, height: 0.02),
                                DeletedNumberSection(numbers: numbers),
                                hight(ctx: context, height: 0.02),

                                OperatorSelection(operators: _operators),
                                hight(ctx: context, height: 0.025),
                                PreviewSection(numbers: numbers),
                                hight(ctx: context, height: 0.03),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerFloat,
          floatingActionButton: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: BlocBuilder<ToggleCubit, bool>(
              builder: (context, state) {
                return SwipeButton(
                  enabled: true,
                  thumb:  Icon(
                    Icons.arrow_forward,
                    color: state ? AppPalette.black : AppPalette.white
                  ),
                  inactiveThumbColor: AppPalette.blue,
                  inactiveTrackColor: AppPalette.blue,
                  activeThumbColor: Colors.blue,
                  activeTrackColor: Colors.blue.shade100,
                  child:  Text(
                    "Swipe to Generate Result?",
                    style: TextStyle(fontSize: 16, color: state ? AppPalette.black : AppPalette.white),
                  ),
                  onSwipe: () {
                    Navigator.pop(context, result);
                  },
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
