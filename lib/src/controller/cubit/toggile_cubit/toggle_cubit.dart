import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmath_ai_calculator/core/local_storage/shared_preferences.dart';

class ToggleCubit extends Cubit<bool> {
  ToggleCubit(super.initialState);

  void toggle() async {
    emit(!state);
    LocalStorage.instance.setBool("isDark", state);
  }
}
