import 'package:flutter_bloc/flutter_bloc.dart';

class AIAssistantVisibilityCubit extends Cubit<bool> {
  AIAssistantVisibilityCubit() : super(false);

  void toggle() {
    emit(!state);
  }
}
