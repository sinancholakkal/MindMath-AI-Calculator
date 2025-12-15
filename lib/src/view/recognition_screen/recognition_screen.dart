import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mindmath_ai_calculator/src/controller/bloc/cubit/select_operation_cubit.dart';
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
  final String _selectedOperator = '+'; // Default operator
  final List<String> _operators = ['+', '-', 'x', '/'];
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
        appBar: AppBar(
          title: const Text(
            'Review & Calculate',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          elevation: 0,
          centerTitle: true,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Image Section
                      ImageSection(widget: widget),
                      const SizedBox(height: 24),

                      // Numbers Detected Section
                      DeletedNumberSection(widget: widget),
                      const SizedBox(height: 24),

                      // Operator Selection Section
                      OperatorSelection(operators: _operators),
                      const SizedBox(height: 24),

                      // Preview Section
                      PreviewSection(widget: widget),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
              // Bottom Action Button
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, result);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.deepPurple,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 2,
                    ),
                    child: const Text(
                      'Calculate Result',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
