import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:payflow/modules/insert_slip/insert_slip_controller.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/themes/appcolors.dart';
import 'package:payflow/shared/widgets/buttons_label/buttons_label.dart';
import 'package:payflow/shared/widgets/input_text/input_text.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class InsertSlipPage extends StatefulWidget {
  final String barcodeValue;

  const InsertSlipPage({this.barcodeValue});

  @override
  _InsertSlipPageState createState() => _InsertSlipPageState();
}

class _InsertSlipPageState extends State<InsertSlipPage>
    with WidgetsBindingObserver {
  final barcodeInputTextController = TextEditingController();
  final dueDateInputTextController = MaskedTextController(mask: "00/00/0000");
  final insertSlipController = InsertSlipController();
  final moneyInputTextController = MoneyMaskedTextController(
    leftSymbol: "R\$",
    thousandSeparator: ".",
    decimalSeparator: ",",
  );

  @override
  void initState() {
    final String barcodeValue = widget.barcodeValue;
    if (barcodeValue != null) {
      barcodeInputTextController.text = barcodeValue;
    }

    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: LayoutBuilder(builder: (context, constraints) {
        final maxHeight = constraints.maxHeight;
        final maxWidth = constraints.maxWidth;

        final apresentationTextHorizontalPadding = maxWidth * 0.25;
        final apresentationTextTopPadding = maxHeight * 0.01;
        final apresentationTextBottomPadding = maxHeight * 0.05;
        final inputTextHeight = maxHeight * 0.088;
        final inputTextWidth = maxWidth * 0.9;
        double inputTextTopPadding = maxHeight * 0.025;

        double buttonsLabelDividerStroke = maxWidth * 0.005;
        double buttonWidth = (maxWidth / 2) - buttonsLabelDividerStroke;
        double buttonHeight = maxHeight * 0.075;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.background,
            elevation: 0,
            leading: BackButton(
              color: AppColors.input,
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(
                    left: apresentationTextHorizontalPadding,
                    right: apresentationTextHorizontalPadding,
                    top: apresentationTextTopPadding,
                    bottom: apresentationTextBottomPadding,
                  ),
                  child: Text(
                    "Preencha os dados do boleto",
                    style: TextStyles.titleBoldHeading,
                    textAlign: TextAlign.center,
                  ),
                ),
                Form(
                  key: insertSlipController.formKey,
                  child: Column(
                    children: [
                      InputText(
                        hintText: "Nome do boleto",
                        icon: Icons.description_outlined,
                        maxHeight: inputTextHeight,
                        maxWidth: inputTextWidth,
                        onChanged: (name) {
                          insertSlipController.onChange(name: name);
                        },
                        validator: insertSlipController.validateName,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: inputTextTopPadding),
                        child: InputText(
                          controller: dueDateInputTextController,
                          hintText: "Vencimento",
                          icon: FontAwesomeIcons.timesCircle,
                          maxHeight: inputTextHeight,
                          maxWidth: inputTextWidth,
                          onChanged: (dueDate) {
                            insertSlipController.onChange(dueDate: dueDate);
                          },
                          validator: insertSlipController.validateDueDate,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: inputTextTopPadding),
                        child: InputText(
                            controller: moneyInputTextController,
                            hintText: "Valor",
                            icon: FontAwesomeIcons.wallet,
                            maxHeight: inputTextHeight,
                            maxWidth: inputTextWidth,
                            onChanged: (_) {
                              insertSlipController.onChange(
                                value: moneyInputTextController.numberValue,
                              );
                            },
                            validator: (_) {
                              double value =
                                  moneyInputTextController.numberValue;
                              return insertSlipController.validateValue(value);
                            }),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: inputTextTopPadding),
                        child: InputText(
                          controller: barcodeInputTextController,
                          hintText: "Código",
                          icon: FontAwesomeIcons.barcode,
                          maxHeight: inputTextHeight,
                          maxWidth: inputTextWidth,
                          onChanged: (barcode) {
                            insertSlipController.onChange(barcode: barcode);
                          },
                          validator: insertSlipController.validateCode,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: ButtonsLabel(
            buttonsWidth: buttonWidth,
            dividerStroke: buttonsLabelDividerStroke,
            primaryButtonLabel: "Cancelar",
            primaryButtonOnTap: () => Navigator.of(context).pop(),
            buttonsHeight: buttonHeight,
            secondaryButtonLabel: "Cadastrar",
            secondaryButtonOnTap: () async {
              await insertSlipController.registerSlip();
              Navigator.pop(context);
            },
            secondaryButtonTextStyle: TextStyles.buttonPrimary,
          ),
        );
      }),
    );
  }
}
