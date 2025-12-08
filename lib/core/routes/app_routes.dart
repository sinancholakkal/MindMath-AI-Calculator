import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mindmath_ai_calculator/src/view/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => LayoutBuilder(
            builder: (context, constraints) {
              double screenWidth = constraints.maxWidth;

              return Scaffold(
                body: Center(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * .04,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Page Not Found',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'The page you were looking for could not be found. '
                          'It might have been removed, renamed, or does not exist.',
                          textAlign: TextAlign.center,
                          softWrap: true,
                          style: TextStyle(fontSize: 16, height: 1.4),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
    }
  }
}
