import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmath_ai_calculator/core/colors/app_palette.dart';

import '../../../controller/toggle_cubit.dart';

class CalcButton extends StatelessWidget {
  final String? text;
  final VoidCallback onTap;
  final Color isBlack;
  final Color isWhite;
  final IconData? iconData;

  const CalcButton({
    super.key,
    this.text,
    required this.onTap,
    required this.isBlack,
    required this.isWhite,
    this.iconData,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToggleCubit, bool>(
      builder: (context, isEnabled) {
        return Container(
          margin: const .all(5.0),
          child: Material(
            color: isEnabled ? isWhite : isBlack,
            borderRadius: .circular(20.0),
            child: InkWell(
              onTap: onTap,
              borderRadius: .circular(20.0),
              child: Container(
                alignment: Alignment.center,
                child: iconData != null
                    ? Center(
                      child: Icon(
                          iconData,
                          color: isEnabled ? AppPalette.white : AppPalette.black,
                          size: 32,
                          
                        ),
                    )
                    : Text(
                        text ?? '',
                        style: TextStyle(
                          color: isEnabled
                              ? AppPalette.white
                              : AppPalette.black,
                          fontSize: 32,
                    fontWeight: .w900,
                        ),
                      ),
              ),
            ),
          ),
        );
      },
    );
  }
}
