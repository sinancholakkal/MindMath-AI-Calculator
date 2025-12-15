import 'package:flutter/material.dart';
import 'package:mindmath_ai_calculator/core/colors/app_palette.dart';
import 'package:mindmath_ai_calculator/core/common/custome_lotties.dart';
import 'package:mindmath_ai_calculator/core/constant/media_quary.dart';
import 'package:mindmath_ai_calculator/core/images/const_images.dart';

class BottomSheetOptions {
  void showBottomSheet({
    required BuildContext context,
    required VoidCallback cameraAction,
    required VoidCallback galleryAction,
    required double screenWidth,
    required double screenHeight,
    required bool currentTheme,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: currentTheme ? AppPalette.black2 : AppPalette.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        final double itemWidth = (screenWidth * 0.9) / 2;
        final double itemHeight = itemWidth;

        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.04,
            vertical: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              hight(ctx: context, height: 0.01),
              Text(
                "Choose Your Image Recognition Method",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Text(
                'After choosing, follow the on‑screen steps to complete your Image Recognition.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 13, color: Colors.grey[700]),
              ),
              hight(ctx: context, height: 0.03),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: cameraAction,
                    child: Container(
                      width: itemWidth,
                      height: itemHeight,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: currentTheme
                            ? AppPalette.black2
                            : AppPalette.white,
                        border: Border.all(
                          color: currentTheme
                              ? const Color.fromARGB(255, 53, 53, 53)
                              : Colors.grey.shade200,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LottieFilesCommon.load(
                            assetPath: takePhoto,
                            width: itemWidth * 0.6,
                            height: itemWidth * 0.6,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Open Camera',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: galleryAction,

                    child: Container(
                      width: itemWidth,
                      height: itemHeight,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: currentTheme
                            ? AppPalette.black2
                            : AppPalette.white,
                        border: Border.all(
                          color: currentTheme
                              ? const Color.fromARGB(255, 53, 53, 53)
                              : Colors.grey.shade200,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          LottieFilesCommon.load(
                            assetPath: gallery,
                            width: itemWidth * 0.6,
                            height: itemWidth * 0.6,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Image from Gallery',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),

              hight(ctx: context, height: 0.016),
            ],
          ),
        );
      },
    );
  }
}
