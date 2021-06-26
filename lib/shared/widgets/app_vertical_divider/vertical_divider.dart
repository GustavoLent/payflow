import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/appcolors.dart';

class AppVerticalDivider extends StatelessWidget {
  final double height;
  final double stroke;

  const AppVerticalDivider(this.height, this.stroke);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: stroke,
      color: AppColors.stroke,
    );
  }
}
