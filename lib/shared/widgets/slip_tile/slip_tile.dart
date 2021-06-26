import 'package:animated_card/animated_card.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:payflow/shared/models/slip_model.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:intl/intl.dart';

class SlipTile extends StatelessWidget {
  final SlipModel slip;
  final currencyFormatter = NumberFormat.currency(
    locale: "pt_BR",
    symbol: "",
  );

  SlipTile(this.slip);

  @override
  Widget build(BuildContext context) {
    String formattedCurrency = currencyFormatter.format(slip.value);
    formattedCurrency = formattedCurrency.trim();

    return AnimatedCard(
      direction: AnimatedCardDirection.left,
      child: ListTile(
        title: AutoSizeText(
          slip.name,
          style: TextStyles.titleListTile,
        ),
        subtitle: AutoSizeText(
          "Vence em: ${slip.dueDate}",
          style: TextStyles.captionBody,
        ),
        trailing: AutoSizeText.rich(
          TextSpan(
            text: "R\$ ",
            style: TextStyles.trailingRegular,
            children: [
              TextSpan(
                text: formattedCurrency,
                style: TextStyles.trailingBold,
              )
            ],
          ),
        ),
      ),
    );
  }
}
