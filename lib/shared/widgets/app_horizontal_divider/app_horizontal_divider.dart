import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/appcolors.dart';

class AppHorizontalDivider extends StatelessWidget {
  final double stroke;
  final double width;

  const AppHorizontalDivider(this.stroke, this.width);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: stroke,
      width: width,
      color: AppColors.stroke,
    );
  }
}
