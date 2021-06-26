import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_images.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/themes/appcolors.dart';

class SocialLoginButton extends StatelessWidget {
  final double maxHeight;
  final double maxWidth;
  final Function onTap;

  const SocialLoginButton({
    Key key,
    @required this.maxHeight,
    @required this.maxWidth,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final borderWidth = maxWidth * 0.005;
    final borderRadius = maxWidth * 0.02;

    final googleIconSize = maxHeight * 0.5;
    final googleIconHorizontalPadding = maxWidth * 0.054;

    final googleTextLeftPadding = maxWidth * 0.16;

    return GestureDetector(
      onTap: () async => await this.onTap(),
      child: Container(
        height: maxHeight,
        width: maxWidth,
        decoration: BoxDecoration(
            color: AppColors.shape,
            border: Border.all(color: AppColors.stroke, width: borderWidth),
            borderRadius: BorderRadius.circular(borderRadius)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: googleIconHorizontalPadding,
              ),
              child: Image.asset(
                AppImages.google,
                height: googleIconSize,
                width: googleIconSize,
              ),
            ),
            Container(
              height: maxHeight,
              width: borderWidth,
              color: AppColors.stroke,
            ),
            Padding(
              padding: EdgeInsets.only(left: googleTextLeftPadding),
              child: AutoSizeText(
                'Entrar com Google',
                style: TextStyles.buttonGray,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
