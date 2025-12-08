import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmath_ai_calculator/core/routes/app_routes.dart';
import 'package:mindmath_ai_calculator/src/controller/toggle_cubit.dart';

import 'core/themes/app_themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ToggleCubit(),
      child: BlocBuilder<ToggleCubit, bool>(
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Math Ai : Calculator',
            theme: state ? AppTheme.darkTheme : AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: state ? ThemeMode.dark : ThemeMode.light,
            initialRoute: '/',
            onGenerateRoute: AppRoutes.onGenerateRoute,
          );
        },
      ),
    );
  }
}
