import 'package:flutter/material.dart';
import 'package:mindmath_ai_calculator/core/colors/app_palette.dart';

class CostumeToggle extends StatefulWidget {
  const CostumeToggle({super.key});

  @override
  State<CostumeToggle> createState() => _CostumeToggleState();
}

class _CostumeToggleState extends State<CostumeToggle> {
  var isEnabled = false;
  final animationDuration = Duration(milliseconds: 400);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isEnabled = !isEnabled;
        });
      },
      child: AnimatedContainer(
        duration: animationDuration,
        height: 40,
        width: 70,
        decoration: BoxDecoration(
          color: Color(0xff989fd5),
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: AppPalette.white, width: 2),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.shade400,
              spreadRadius: 2,
              blurRadius: 10,
            ),
          ],
        ),
        child: Stack(
          alignment: .center,

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: .only(left: 8),
                  child: Icon(Icons.dark_mode, size: 20),
                ),
                Padding(
                  padding: .only(right: 8),
                  child: Icon(Icons.light_mode, size: 20),
                ),
              ],
            ),
            AnimatedAlign(
              alignment: isEnabled
                  ? Alignment.centerRight
                  : Alignment.centerLeft,
              duration: animationDuration,
              child: Padding(
                padding: .symmetric(horizontal: 2),
                child: AnimatedContainer(
                  duration: animationDuration,
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
