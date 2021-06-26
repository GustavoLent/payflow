import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_images.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/themes/appcolors.dart';
import 'package:payflow/shared/widgets/app_vertical_divider/vertical_divider.dart';

class PendingSlips extends StatelessWidget {
  final int amount;
  final double maxHeight;
  final double maxWidth;

  const PendingSlips(
    this.amount,
    this.maxHeight,
    this.maxWidth,
  );

  @override
  Widget build(BuildContext context) {
    double radius = maxWidth * 0.01;
    double horizontalPadding = maxWidth * 0.06;
    double verticalPadding = maxHeight * 0.2;

    double dividerStroke = maxWidth * 0.005;
    double dividerHeight = maxHeight - (2 * verticalPadding);
    double dividerHorizontalPadding = maxWidth * 0.1;

    return Container(
      height: maxHeight,
      width: maxWidth,
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: verticalPadding,
      ),
      decoration: BoxDecoration(
        color: AppColors.gray,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          barcodeImage(),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: dividerHorizontalPadding,
            ),
            child: AppVerticalDivider(dividerHeight, dividerStroke),
          ),
          pendingSlipsText(),
        ],
      ),
    );
  }

  Widget barcodeImage() {
    return Image.asset(
      AppImages.logomini,
      color: AppColors.background,
    );
  }

  Widget pendingSlipsText() {
    return AutoSizeText.rich(
      TextSpan(
          text: "Você tem ",
          style: TextStyles.captionBackground,
          children: <TextSpan>[
            TextSpan(
              text: "$amount boletos\n",
              style: TextStyles.captionBoldBackground,
            ),
            TextSpan(
              text: "cadastrados para pagar",
              style: TextStyles.captionBackground,
            ),
          ]),
      textAlign: TextAlign.left,
    );
  }
}
