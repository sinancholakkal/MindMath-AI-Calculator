import 'package:flutter/cupertino.dart';
import 'package:mindmath_ai_calculator/core/colors/app_palette.dart';

class CustomCupertinoDialog {
  static void show({
    required BuildContext context,
    required String title,
    required String message,
  }) {
    showCupertinoDialog(
      context: context,
      builder:
          (_) => CupertinoAlertDialog(
            title: Text(title),
            content: Text(message),
            actions: [
              CupertinoDialogAction(
                child: Text(
                  "Got it",
                  style: TextStyle(color: AppPalette.blue),
                ),
                onPressed: () {
                  if (Navigator.canPop(context)) {
                      Navigator.of(context).pop();
                  }
                },
              ),
            ],
          ),
    );
  }
}