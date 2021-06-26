import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/app_horizontal_divider/app_horizontal_divider.dart';
import 'package:payflow/shared/widgets/slip_list/slip_list.dart';
import 'package:payflow/shared/widgets/slip_list/slip_list_controller.dart';

class SlipsStatementPage extends StatefulWidget {
  const SlipsStatementPage({Key key}) : super(key: key);

  @override
  _SlipsStatementPageState createState() => _SlipsStatementPageState();
}

class _SlipsStatementPageState extends State<SlipsStatementPage> {
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
            "Meus extratos",
            style: TextStyles.titleBoldHeading,
          ),
          AutoSizeText(
            "x pagos",
            style: TextStyles.trailingBold,
          ),
        ],
      ),
    );
  }
}
