import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mindmath_ai_calculator/core/colors/app_palette.dart';
import 'package:mindmath_ai_calculator/src/controller/bloc/image_pick/image_pick_bloc.dart';
import 'package:mindmath_ai_calculator/src/controller/cubit/toggile_cubit/toggle_cubit.dart';
import 'package:mindmath_ai_calculator/core/common/custome_options.dart';

import '../images/const_images.dart';

class ScannerButton extends StatelessWidget {
  final void Function() actionRight;
  final void Function() actionLeft;
  const ScannerButton({
    super.key,
    required this.actionRight,
    required this.actionLeft,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToggleCubit, bool>(
      builder: (context, isEnabled) {
        return Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            color: isEnabled
                ? AppPalette.black2.withValues(alpha: 0.6)
                : AppPalette.hint,
            borderRadius: .circular(40),
          ),
          child: Center(
            child: IconButton(
              onPressed: () {
                BottomSheetOptions().showBottomSheet(
                  mainText: "Choose Your Image Recognition Method",
                  subText:
                      'After choosing, follow the on‑screen steps to complete your Image Recognition.',
                  context: context,
                  screenHeight: MediaQuery.of(context).size.height,
                  screenWidth: MediaQuery.of(context).size.width,
                  actionLeft: actionLeft,
                  lottieLeft: takePhoto,
                  textLeft: 'Open Camera',
                  lottieRight: gallery,
                  textRight: 'Image from Gallery',
                  actionRight: actionRight,
                  currentTheme: isEnabled,
                );
              },
              icon: Icon(
                Icons.document_scanner,
                size: 18,
                color: isEnabled ? AppPalette.white : AppPalette.black2,
              ),
            ),
          ),
        );
      },
    );
  }
}
