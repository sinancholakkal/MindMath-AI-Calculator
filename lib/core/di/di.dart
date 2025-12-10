import 'package:get_it/get_it.dart';
import 'package:mindmath_ai_calculator/src/controller/cubit/speech_cubit/speech_cubit.dart';
import 'package:speech_to_text/speech_to_text.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerLazySingleton<SpeechToText>(() => SpeechToText());
  sl.registerFactory<SpeechCubit>(() => SpeechCubit(speech: sl()));
}
