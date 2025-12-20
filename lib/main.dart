import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmath_ai_calculator/core/di/di.dart';
import 'package:mindmath_ai_calculator/core/local_storage/shared_preferences.dart';
import 'package:mindmath_ai_calculator/core/routes/app_routes.dart';
import 'package:mindmath_ai_calculator/src/controller/bloc/arithmetical/arithmetical_bloc.dart';
import 'package:mindmath_ai_calculator/src/controller/bloc/cubit/select_operation_cubit.dart';
import 'package:mindmath_ai_calculator/src/controller/bloc/image_pick/image_pick_bloc.dart';
import 'package:mindmath_ai_calculator/src/controller/cubit/speech_cubit/speech_cubit.dart';
import 'package:mindmath_ai_calculator/src/controller/cubit/toggile_cubit/toggle_cubit.dart';

import 'core/themes/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  final localStorage = await LocalStorage.init();
  bool isDark = localStorage.getBool("isDark") ?? true;

  runApp(MyApp(isDark: isDark));
}

class MyApp extends StatelessWidget {
  final bool isDark;
  const MyApp({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToggleCubit(isDark),
      child: BlocBuilder<ToggleCubit, bool>(
        builder: (context, state) {
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => ArithmeticalBloc()),
              BlocProvider(create: (context) => ImagePickBloc()),
              BlocProvider(create: (context) => SelectOperationCubit()),
              BlocProvider(create: (context) => sl<SpeechCubit>()..init()),
            ],
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Math Ai : Calculator',
              theme: state ? AppTheme.darkTheme : AppTheme.lightTheme,
              darkTheme: AppTheme.darkTheme,
              themeMode: state ? ThemeMode.dark : ThemeMode.light,
              initialRoute: '/',
              onGenerateRoute: AppRoutes.onGenerateRoute,
            ),
          );
        },
      ),
    );
  }
}
