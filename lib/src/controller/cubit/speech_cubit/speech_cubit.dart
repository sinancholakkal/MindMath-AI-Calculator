import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_to_text.dart';
part 'speech_state.dart';

class SpeechCubit extends Cubit<SpeechState> {
  final SpeechToText speech;
  SpeechCubit({required this.speech})
    : super(SpeechState(isListening: false, recognizedText: ""));

  Future<void> init() async {
    await speech.initialize();
  }

  bool _isRequestingPermission = false;

  Future<bool> checkMicPermission() async {
    if (_isRequestingPermission) {
      return false;
    }

    _isRequestingPermission = true;
    try {
      var status = await Permission.microphone.status;

      if (status.isGranted) return true;

      if (status.isDenied) {
        var requestStatus = await Permission.microphone.request();
        return requestStatus.isGranted;
      }

      if (status.isPermanentlyDenied || status.isRestricted) {
        await openAppSettings();
        return false;
      }

      return false;
    } finally {
      _isRequestingPermission = false;
    }
  }

  Future<void> startListening() async {
    await speech.listen(
      onResult: (result) {
        String recognized = result.recognizedWords;

        final filtered = RegExp(
          r'[0-9+\-*/%.()]',
        ).allMatches(recognized).map((m) => m.group(0)).join();
        emit(state.copyWith(recognizedText: filtered));
      },
    );
    emit(state.copyWith(isListening: true));
  }

  Future<void> stopListening() async {
    await speech.stop();
    emit(state.copyWith(isListening: false));
  }
}
