import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:payflow/modules/login/login_controller.dart';
import 'package:payflow/shared/themes/app_images.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/themes/appcolors.dart';
import 'package:payflow/shared/widgets/social_login/social_login_button.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        final maxHeight = constraints.maxHeight;
        final maxWidth = constraints.maxWidth;

        final headerHeight = maxHeight * 0.36;
        final headerWidth = maxWidth;

        final personImageHeight = maxHeight * 0.45;
        final personImageWidth = maxWidth * 0.55;
        final personImageTopPadding = maxHeight * 0.045;

        final barcodeImageAndHomeTextTopPadding = maxHeight * 0.53;

        final barcodeImageHeight = maxHeight * 0.054;
        final barcodeImageWidth = maxWidth * 0.192;

        final homeTextHeight = maxHeight * 0.22;
        final homeTextWidth = maxWidth * 0.64;
        final homeTextTopPadding = maxHeight * 0.029;

        final socialLoginButtonHeight = maxHeight * 0.068;
        final socialLoginButtonWidth = maxWidth * 0.78;
        final socialLoginButtonTopPadding = maxHeight * 0.049;

        return Scaffold(
          backgroundColor: AppColors.background,
          body: Container(
            height: maxHeight,
            width: maxWidth,
            child: Stack(
              alignment: Alignment.topCenter,
              children: <Widget>[
                Container(
                  height: headerHeight,
                  width: headerWidth,
                  color: AppColors.primary,
                ),
                Padding(
                  padding: EdgeInsets.only(top: personImageTopPadding),
                  child: Image.asset(
                    AppImages.person,
                    height: personImageHeight,
                    width: personImageWidth,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: barcodeImageAndHomeTextTopPadding,
                  ),
                  child: Column(
                    children: <Widget>[
                      Image.asset(
                        AppImages.logomini,
                        height: barcodeImageHeight,
                        width: barcodeImageWidth,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: homeTextTopPadding),
                        child: Container(
                          height: homeTextHeight,
                          width: homeTextWidth,
                          child: AutoSizeText(
                            "Organize seus boletos em um só lugar",
                            style: TextStyles.titleHome,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: socialLoginButtonTopPadding,
                        ),
                        child: SocialLoginButton(
                          maxHeight: socialLoginButtonHeight,
                          maxWidth: socialLoginButtonWidth,
                          onTap: () {
                            loginController.gogleSignIn(context);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
