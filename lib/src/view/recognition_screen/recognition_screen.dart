
import 'dart:developer';
import 'dart:io';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mindmath_ai_calculator/core/colors/app_palette.dart';
import 'package:mindmath_ai_calculator/core/common/custome_appbar.dart';
import 'package:mindmath_ai_calculator/core/constant/media_quary.dart';
import 'package:mindmath_ai_calculator/src/controller/bloc/cubit/select_operation_cubit.dart';
import 'package:mindmath_ai_calculator/src/controller/cubit/toggile_cubit/toggle_cubit.dart';
import 'package:mindmath_ai_calculator/src/view/recognition_screen/widgets/delete_number_section.dart';
import 'package:mindmath_ai_calculator/src/view/recognition_screen/widgets/image_section.dart';
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
    return BlocListener<SelectOperationCubit, String>(
      listener: (context, state) {
        result = widget.numbers.join(state);
      },
      child: Scaffold(
        appBar: CustomAppBar(title: 'Review & Calculate', isTitle: true),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: .start,
            crossAxisAlignment: .start,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      ImageSection(widget: widget),
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
                                    color:isEnable ?  AppPalette.white : AppPalette.black,
                                    fontSize: 15,
                                  ),
                                ),
                                TextSpan(
                                  text: "Tab to Result",
                                  style: const TextStyle(
                                    color: AppPalette.blue,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    decoration:   TextDecoration.underline,
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
        ),
      ),
    );
  }
}
