import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mindmath_ai_calculator/core/colors/app_palette.dart';
import 'package:mindmath_ai_calculator/core/constant/media_quary.dart';
import 'package:mindmath_ai_calculator/src/controller/cubit/toggile_cubit/toggle_cubit.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  final Size preferredSize;
  final String? title;
  final Color? backgroundColor;
  final bool? isTitle;
  final Color? iconColor;
  final List<Widget>? actions;
  const CustomAppBar({
    super.key,
    this.title,
    this.backgroundColor,
    this.iconColor,
    this.isTitle = false,
    this.actions,
  }) : preferredSize = const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ToggleCubit, bool>(
      builder: (context, isEnable) {
        return AppBar(
          centerTitle: true,
          leadingWidth: 120,
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              children: [
                width(context: context, width: 0.02),
                Icon(
                  Icons.arrow_back_ios_new_rounded,
                  color: AppPalette.blue,
                  size: 20,
                ),
                Flexible(
                  child: Text(
                    'Calculator',
                    style: TextStyle(
                      color: AppPalette.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          title: isTitle == true
              ? Text(
                  title!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  textAlign: TextAlign.center,
                )
              : null,
          actions: actions,

          backgroundColor: isEnable ? AppPalette.black : AppPalette.white,
          surfaceTintColor: Colors.transparent,
          automaticallyImplyLeading: true,
          elevation: 4,
          shadowColor: isEnable
              ? const Color.fromARGB(255, 68, 68, 68)
              : AppPalette.black.withValues(alpha: 0.2),
          scrolledUnderElevation: 4,
          titleSpacing: 0,
          iconTheme: IconThemeData(
            color: isEnable ? AppPalette.white : AppPalette.black,
          ),
        );
      },
    );
  }
}
