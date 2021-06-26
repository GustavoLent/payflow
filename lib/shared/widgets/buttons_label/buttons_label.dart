import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/appcolors.dart';
import 'package:payflow/shared/widgets/app_horizontal_divider/app_horizontal_divider.dart';
import 'package:payflow/shared/widgets/app_vertical_divider/vertical_divider.dart';
import 'package:payflow/shared/widgets/label_button/label_button.dart';

class ButtonsLabel extends StatelessWidget {
  final double buttonsWidth;
  final double dividerStroke;
  final String primaryButtonLabel;
  final VoidCallback primaryButtonOnTap;
  final TextStyle primaryButtonTextStyle;
  final double buttonsHeight;
  final String secondaryButtonLabel;
  final VoidCallback secondaryButtonOnTap;
  final TextStyle secondaryButtonTextStyle;

  const ButtonsLabel({
    @required this.buttonsWidth,
    @required this.dividerStroke,
    @required this.primaryButtonLabel,
    @required this.primaryButtonOnTap,
    this.primaryButtonTextStyle,
    @required this.buttonsHeight,
    @required this.secondaryButtonLabel,
    @required this.secondaryButtonOnTap,
    this.secondaryButtonTextStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        AppHorizontalDivider(dividerStroke, double.maxFinite),
        Container(
          color: AppColors.shape,
          child: Row(
            children: [
              LabelButton(
                primaryButtonLabel,
                buttonsHeight,
                buttonsWidth,
                primaryButtonOnTap,
                textStyle: primaryButtonTextStyle,
              ),
              AppVerticalDivider(buttonsHeight, dividerStroke),
              LabelButton(
                secondaryButtonLabel,
                buttonsHeight,
                buttonsWidth,
                secondaryButtonOnTap,
                textStyle: secondaryButtonTextStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
