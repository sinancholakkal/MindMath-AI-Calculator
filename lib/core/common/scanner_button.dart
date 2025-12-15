
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mindmath_ai_calculator/core/colors/app_palette.dart';
import 'package:mindmath_ai_calculator/src/controller/bloc/image_pick/image_pick_bloc.dart';
import 'package:mindmath_ai_calculator/src/controller/cubit/toggile_cubit/toggle_cubit.dart';
import 'package:mindmath_ai_calculator/src/view/home/widgets/calc_camara_option.dart';

class ScannerButton extends StatelessWidget {
  const ScannerButton({super.key});

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
                  context: context,
                  screenHeight: MediaQuery.of(context).size.height,
                  screenWidth: MediaQuery.of(context).size.width,
                  cameraAction: () {
                    context.read<ImagePickBloc>().add(
                      ImagePickerEvent(source: ImageSource.camera),
                    );
                    Navigator.pop(context);
                  },
                  galleryAction: () {
                    context.read<ImagePickBloc>().add(
                      ImagePickerEvent(source: ImageSource.gallery),
                    );
                    Navigator.pop(context);
                  },
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
