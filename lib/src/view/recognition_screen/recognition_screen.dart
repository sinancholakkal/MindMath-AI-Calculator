import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

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
  String formated = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recognition Screen')),
      body: SingleChildScrollView(
        child: Column(
          spacing: 10,
          children: [
            SizedBox(
              width: double.infinity,
              child: Image.file(File(widget.image.path), fit: BoxFit.cover),
            ),
            Text(
              widget.numbers.isEmpty
                  ? "No numbers found"
                  : widget.numbers.join(",").toString(),
              style: const TextStyle(fontSize: 24),
            ),
            Text(formated, style: const TextStyle(fontSize: 24)),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          formated = widget.numbers.join("+");
          Navigator.pop(context, formated);
        },
      ),
    );
  }
}
