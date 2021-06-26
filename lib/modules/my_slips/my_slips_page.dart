import 'package:animated_card/animated_card.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:payflow/shared/models/slip_model.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/themes/appcolors.dart';
import 'package:payflow/shared/widgets/app_horizontal_divider/app_horizontal_divider.dart';
import 'package:payflow/shared/widgets/pending_slips/pending_slips.dart';
import 'package:payflow/shared/widgets/slip_list/slip_list.dart';
import 'package:payflow/shared/widgets/slip_list/slip_list_controller.dart';

class MySlipsPage extends StatefulWidget {
  const MySlipsPage({Key key}) : super(key: key);

  @override
  _MySlipsPageState createState() => _MySlipsPageState();
}

class _MySlipsPageState extends State<MySlipsPage> {
  final slipListController = SlipListController();

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async => await slipListController.getSlips(),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final maxHeight = constraints.maxHeight;
        final maxWidth = constraints.maxWidth;

        final mySlipsTextHeight = maxHeight * 0.05;
        final mySlipsTextVerticalPadding = maxHeight * 0.05;

        final dividerStroke = maxHeight * 0.0025;

        final pageHorizontalPadding = maxWidth * 0.045;

        final pendingSlipsHeight = maxHeight * 0.135;
        final pendingSlipsWidth = maxWidth - (2 * pageHorizontalPadding);

        final slipListHeight = maxHeight -
            mySlipsTextHeight -
            (2 * mySlipsTextVerticalPadding) -
            pendingSlipsHeight -
            dividerStroke;
        final slipListWidth = maxWidth - (2 * pageHorizontalPadding);

        return Container(
          height: maxHeight,
          width: maxWidth,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    height: pendingSlipsHeight / 2,
                    width: double.maxFinite,
                    color: AppColors.primary,
                  ),
                  ValueListenableBuilder<List<SlipModel>>(
                      valueListenable: slipListController.slipNotifier,
                      builder: (_, slips, __) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: pageHorizontalPadding,
                          ),
                          child: AnimatedCard(
                            direction: AnimatedCardDirection.top,
                            child: PendingSlips(
                              slips.length,
                              pendingSlipsHeight,
                              pendingSlipsWidth,
                            ),
                          ),
                        );
                      }),
                ],
              ),
              Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: mySlipsTextVerticalPadding,
                    horizontal: pageHorizontalPadding,
                  ),
                  child: mySlipsText(mySlipsTextHeight)),
              Padding(
                padding: EdgeInsets.only(
                  left: pageHorizontalPadding,
                  right: pageHorizontalPadding,
                ),
                child: AppHorizontalDivider(dividerStroke, maxWidth),
              ),
              SlipList(slipListHeight, slipListWidth, slipListController),
            ],
          ),
        );
      },
    );
  }

  Widget mySlipsText(double maxHeight) {
    return Container(
      height: maxHeight,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          AutoSizeText(
            "Meus boletos",
            style: TextStyles.titleBoldHeading,
          ),
          AutoSizeText(
            "x ao total",
            style: TextStyles.trailingBold,
          ),
        ],
      ),
    );
  }
}
