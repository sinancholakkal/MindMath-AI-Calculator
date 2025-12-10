part of 'speech_cubit.dart';

@immutable
class SpeechState {
  final bool isListening;
  final String recognizedText;


  const SpeechState({
    required this.isListening,
    required this.recognizedText
  });

  SpeechState copyWith({
    bool? isListening,
    String? recognizedText,
  }) {
    return SpeechState(
      isListening: isListening ?? this.isListening, 
      recognizedText: recognizedText ?? this.recognizedText);
  }


}