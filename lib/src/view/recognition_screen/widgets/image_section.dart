import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mindmath_ai_calculator/core/common/custome_lotties.dart';
import 'package:mindmath_ai_calculator/core/images/const_images.dart';
import 'package:mindmath_ai_calculator/src/view/recognition_screen/recognition_screen.dart';
import 'package:photo_view/photo_view.dart';

class ImageSection extends StatelessWidget {
  const ImageSection({super.key, required this.widget});

  final RecognitionScreen widget;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: .centerLeft,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: 150,
        
              child: Hero(
                tag: 'zoom-image',
                child: Image.file(
                  File(widget.image.path),
                  fit: BoxFit.contain,
                  width: double.infinity,
                ),
              ),
            
          ),
          LottieFilesCommon.load(
            assetPath: scanning,
            width: double.infinity,
            height: 150,
          ),
          Positioned(
            top: 0,
            left: 0,
            child: IconButton(
              icon: const Icon(Icons.zoom_in, size: 20),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => Dialog(
                    insetPadding: EdgeInsets.zero,
                    backgroundColor: Colors.black,
                    child: PhotoView(
                      imageProvider: FileImage(File(widget.image.path)),

                      initialScale: PhotoViewComputedScale.contained,
                      minScale: PhotoViewComputedScale.contained,
                      maxScale: PhotoViewComputedScale.covered * 4,

                      gestureDetectorBehavior: HitTestBehavior.opaque,

                      filterQuality: FilterQuality.high,
                      heroAttributes: const PhotoViewHeroAttributes(
                        tag: 'zoom-image',
                      ),

                      loadingBuilder: (context, event) =>
                          const Center(child: CircularProgressIndicator()),
                      errorBuilder: (context, error, stackTrace) =>
                          const Center(
                            child: Icon(
                              Icons.broken_image,
                              color: Colors.white,
                              size: 40,
                            ),
                          ),

                      onTapUp: (_, __, _) {
                        Navigator.of(context).pop();
                      },

                      semanticLabel: 'Zoomed product image',
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
