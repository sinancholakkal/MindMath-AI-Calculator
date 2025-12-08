import 'package:flutter/material.dart';
import 'package:mindmath_ai_calculator/core/common/costume_toggle.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: CostumeToggle()));
  }
}
