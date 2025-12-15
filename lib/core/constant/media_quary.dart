import 'package:flutter/material.dart';

class MediaQuaryHelper {
  static double width(BuildContext context) => MediaQuery.of(context).size.width;
  static double height(BuildContext context) => MediaQuery.of(context).size.height;
}

Widget hight({required BuildContext ctx, required double height}) {
    return SizedBox(height: MediaQuaryHelper.height(ctx) * height);
  }
Widget width({required BuildContext context, required double width}){
    return SizedBox(width: MediaQuaryHelper.width(context) * width);
  }
