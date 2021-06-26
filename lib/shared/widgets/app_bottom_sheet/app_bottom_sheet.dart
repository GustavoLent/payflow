import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/themes/appcolors.dart';
import 'package:payflow/shared/widgets/buttons_label/buttons_label.dart';

class AppBottomSheet extends StatelessWidget {
  final double buttonsWidth;
  final double buttonsHeight;
  final double dividerStroke;
  final String primaryButtonLabel;
  final VoidCallback primaryButtonOnTap;
  final TextStyle primaryButtonTextStyle;
  final double maxHeight;
  final String secondaryButtonLabel;
  final VoidCallback secondaryButtonOnTap;
  final TextStyle secondaryButtonTextStyle;
  final String subtitle;
  final String title;

  const AppBottomSheet({
    @required this.buttonsWidth,
    @required this.buttonsHeight,
    @required this.dividerStroke,
    @required this.primaryButtonLabel,
    @required this.primaryButtonOnTap,
    this.primaryButtonTextStyle,
    @required this.maxHeight,
    @required this.secondaryButtonLabel,
    @required this.secondaryButtonOnTap,
    this.secondaryButtonTextStyle,
    @required this.subtitle,
    @required this.title,
  });

  @override
  Widget build(BuildContext context) {
    double textsHeight = maxHeight * 0.1;
    double textsVerticalPadding = maxHeight * 0.075;

    double bottomSheetHeight = (2 * textsVerticalPadding) +
        textsHeight +
        buttonsHeight +
        dividerStroke;
    double opacityContainerHeight = maxHeight - bottomSheetHeight;

    return Container(
      color: AppColors.shape,
      child: Column(
        children: [
          Container(
            height: opacityContainerHeight,
            color: Colors.black.withOpacity(0.6),
          ),
          Container(
            height: bottomSheetHeight,
            alignment: Alignment.bottomCenter,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: textsVerticalPadding,
                  ),
                  child: Column(
                    children: [
                      AutoSizeText(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyles.buttonBoldHeading,
                      ),
                      AutoSizeText(
                        subtitle,
                        textAlign: TextAlign.center,
                        style: TextStyles.buttonHeading,
                      ),
                    ],
                  ),
                ),
                ButtonsLabel(
                  buttonsWidth: buttonsWidth,
                  dividerStroke: dividerStroke,
                  primaryButtonLabel: primaryButtonLabel,
                  primaryButtonOnTap: primaryButtonOnTap,
                  primaryButtonTextStyle: primaryButtonTextStyle,
                  buttonsHeight: buttonsHeight,
                  secondaryButtonLabel: secondaryButtonLabel,
                  secondaryButtonOnTap: secondaryButtonOnTap,
                  secondaryButtonTextStyle: secondaryButtonTextStyle,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
