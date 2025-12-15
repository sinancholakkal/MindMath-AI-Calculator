import 'dart:developer';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:meta/meta.dart';

part 'ai_recognition_event.dart';
part 'ai_recognition_state.dart';

class AiRecognitionBloc extends Bloc<AiRecognitionEvent, AiRecognitionState> {
  AiRecognitionBloc() : super(AiRecognitionInitial()) {
    on<AiRecognitionImageEvent>((event, emit) async {
      log("started AI Recognition");
      final apiKey = "AIzaSyAWMVrrGDcCh9qt06cFkk-DyK92rQz4ABw";
      final model = GenerativeModel(model: "gemini-2.5-flash", apiKey: apiKey);

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
        log("AI Saw: ${response.text}");
      } catch (e) {
        log(e.toString());
      }
    });
  }
}
