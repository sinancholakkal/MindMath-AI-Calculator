part of 'ai_recognition_bloc.dart';

@immutable
sealed class AiRecognitionEvent {}

class AiRecognitionImageEvent extends AiRecognitionEvent {
  final File image;

  AiRecognitionImageEvent({required this.image});
}
