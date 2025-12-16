import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToggleCubit extends Cubit<bool> {
  ToggleCubit() : super(false) {
   init ();
  }

  void toggle() async {
    emit(!state);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool("isDark", state);
    log(prefs.getBool("isDark").toString());
  }

  void init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    emit(prefs.getBool("isDark") ?? true);
  }
}
