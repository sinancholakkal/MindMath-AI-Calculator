import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:mindmath_ai_calculator/core/keys/key.dart';

part 'image_pick_event.dart';
part 'image_pick_state.dart';

class ImagePickBloc extends Bloc<ImagePickEvent, ImagePickState> {
  ImagePickBloc() : super(ImagePickInitial()) {
    on<ImagePickerEvent>((event, emit) async {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: event.source);
      final List<num> numbers = [];
      if (image != null) {
        emit(ImagePickLoading());
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
    on<ImageAiProcessingEvent>((event, emit) async {
      emit(ImagePickLoading());
      log("started AI Recognition");

      final model = GenerativeModel(model: "gemini-2.5-flash", apiKey: aiKey);

      final imageBytes = await event.image.readAsBytes();

      final content = [
        Content.multi([
          TextPart(
            "Look at this image. Extract ONLY the numbers. Ignore all mathematical symbols (+, -, *, /), text, and currency signs. Return just the numbers, separated by spaces.",
          ),
          DataPart('image/jpeg', imageBytes),
        ]),
      ];
      try {
        log("AI response waiting");
        final response = await model.generateContent(content);
        final List<num> numbers = [];
        if (response.text == null) {
          emit(ImagePickLoaded(image: event.image, numbers: numbers));
        } else {
          for (var element in response.text!.split(" ")) {
            num? n = num.tryParse(element.trim());
            if (n != null) {
              numbers.add(n);
            }
          }
          emit(ImagePickLoaded(image: event.image, numbers: numbers));
        }

        log("AI Saw: ${response.text}");
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
