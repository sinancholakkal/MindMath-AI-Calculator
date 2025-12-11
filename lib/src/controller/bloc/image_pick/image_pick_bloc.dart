import 'dart:developer';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'image_pick_event.dart';
part 'image_pick_state.dart';

class ImagePickBloc extends Bloc<ImagePickEvent, ImagePickState> {
  ImagePickBloc() : super(ImagePickInitial()) {
    on<ImagePickerEvent>((event, emit) async {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: event.source);
      final List<num> numbers = [];
      if (image != null) {
        final InputImage inputImage = InputImage.fromFile(File(image.path));

        final textRecognizer = TextRecognizer(
          script: TextRecognitionScript.latin,
        );

        final RecognizedText recognizedText = await textRecognizer.processImage(
          inputImage,
        );

        for (TextBlock block in recognizedText.blocks) {
          for (TextLine line in block.lines) {
            for (TextElement element in line.elements) {
              num? n = num.tryParse(element.text.trim());
              if (n != null) {
                numbers.add(n);
              }
            }
          }
        }
        print(numbers);
        emit(ImagePickLoaded(image: image, numbers: numbers));
      } else {
        emit(ImagePickError(message: "Image not selected"));
      }
    });
  }
}
