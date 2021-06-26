import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';

class LabelButton extends StatelessWidget {
  final String label;
  final double maxHeight;
  final double maxWidth;
  final VoidCallback onPressed;
  final TextStyle textStyle;

  LabelButton(
    this.label,
    this.maxHeight,
    this.maxWidth,
    this.onPressed, {
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    TextStyle style = textStyle == null ? TextStyles.buttonHeading : textStyle;

    return Container(
      height: maxHeight,
      width: maxWidth,
      child: TextButton(
        onPressed: () => onPressed(),
        child: AutoSizeText(label, style: style),
      ),
    );
  }
}
