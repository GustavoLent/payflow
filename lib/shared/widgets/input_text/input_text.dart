import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/themes/appcolors.dart';
import 'package:payflow/shared/widgets/app_vertical_divider/vertical_divider.dart';

class InputText extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final double maxHeight;
  final double maxWidth;
  final void Function(String) onChanged;
  final String Function(String) validator;

  const InputText({
    this.controller,
    @required this.hintText,
    @required this.icon,
    @required this.maxHeight,
    @required this.maxWidth,
    @required this.onChanged,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    double iconHorizontalPadding = maxWidth * 0.03;
    double dividerStroke = maxWidth * 0.005;

    double verticalDividerHeight = maxHeight - dividerStroke;

    return AnimatedCard(
      direction: AnimatedCardDirection.left,
      child: Container(
        width: maxWidth,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              controller: controller,
              validator: validator,
              onChanged: onChanged,
              style: TextStyles.input,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintText: hintText,
                hintStyle: TextStyles.input,
                icon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: iconHorizontalPadding,
                      ),
                      child: Icon(
                        icon,
                        color: AppColors.primary,
                      ),
                    ),
                    AppVerticalDivider(verticalDividerHeight, dividerStroke),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
